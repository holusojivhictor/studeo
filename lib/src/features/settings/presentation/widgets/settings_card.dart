import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studeo/src/features/common/application/bloc.dart';
import 'package:studeo/src/features/common/domain/enums/enums.dart';
import 'package:studeo/src/features/common/presentation/popup_menu/item_popup_menu_filter.dart';
import 'package:studeo/src/features/settings/presentation/widgets/tiles/tiles.dart';

class AppSettingsCard extends StatelessWidget {
  const AppSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (ctx, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsListTile(
            title: 'Follow OS theme',
            trailing: ItemPopupMenuFilter<AutoThemeModeType>(
              toolTipText: 'Auto Theme Mode',
              selectedValue: state.themeMode,
              values: AutoThemeModeType.values,
              onSelected: (newVal) => context.read<SettingsBloc>().add(
                  SettingsEvent.autoThemeModeTypeChanged(newValue: newVal),),
              icon: const Icon(Icons.expand_more),
              itemText: (val, _) => val.translate,
            ),
          ),
          SettingsSwitchListTile(
            title: 'Dark Mode',
            value: state.currentTheme.darkMode,
            onChanged: state.themeMode == AutoThemeModeType.off
                ? (newVal) => context.read<SettingsBloc>().add(
                    SettingsEvent.themeChanged(
                        newValue: AppThemeType.translate(newVal),),)
                : null,
          ),
          SettingsListTile(
            title: 'Language',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.currentLanguage.translate,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                ItemPopupMenuFilter<AppLanguageType>(
                  toolTipText: 'App Language',
                  selectedValue: state.currentLanguage,
                  values: AppLanguageType.values,
                  onSelected: (newVal) => context
                      .read<SettingsBloc>()
                      .add(SettingsEvent.languageChanged(newValue: newVal)),
                  icon: const Icon(Icons.keyboard_arrow_right),
                  itemText: (val, _) => val.translate,
                ),
              ],
            ),
          ),
          SettingsSwitchListTile(
            title: 'Press back to exit',
            value: state.doubleBackToClose,
            onChanged: (newVal) => context
                .read<SettingsBloc>()
                .add(SettingsEvent.doubleBackToCloseChanged(newValue: newVal)),
          ),
          SettingsSwitchListTile(
            title: 'Show complex grid',
            value: state.complexGridTile,
            onChanged: (newVal) => context
                .read<SettingsBloc>()
                .add(SettingsEvent.complexGridTileChanged(newValue: newVal)),
          ),
          SettingsListTile(
            title: 'Version',
            trailing: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                state.appVersion,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
