import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studeo/src/extensions/extensions.dart';
import 'package:studeo/src/features/common/application/bloc.dart';
import 'package:studeo/src/features/gallery/application/gallery_bloc.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/app_bar/gallery_app_bar.dart';
import 'package:studeo/src/features/gallery/presentation/widgets/gallery_grid_view.dart';
import 'package:studeo/src/features/item/domain/models/models.dart';
import 'package:studeo/src/routing/app_router.dart';
import 'package:studeo/src/utils/utils.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool _didChangeDependencies = false;
  DateTime? backButtonPressTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didChangeDependencies) return;
    _didChangeDependencies = true;
    context.read<GalleryBloc>().add(const GalleryEvent.init());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleWillPop,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) =>
            previous.complexGridTile != current.complexGridTile,
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            appBar: GalleryAppBar(
              backgroundColor: Colors.transparent,
            ),
            body: GalleryGridView(
              onItemTapped: onItemTapped,
            ),
          );
        },
      ),
    );
  }

  void onItemTapped(Item item, int index) {
    final args = ItemPageArgs(item: item, index: index);

    context.go(AppRoute.item.path, extra: args);
  }

  Future<bool> handleWillPop() async {
    final settings = context.read<SettingsBloc>();
    if (!settings.doubleBackToClose) {
      return true;
    }

    final now = DateTime.now();
    final mustWait = backButtonPressTime == null ||
        now.difference(backButtonPressTime!) > ToastUtils.toastDuration;

    if (mustWait) {
      backButtonPressTime = now;
      final fToast = ToastUtils.of(context);
      ToastUtils.showInfoToast(fToast, 'Press once again to exit'.hardcoded);
      return false;
    }

    return true;
  }
}
