import 'package:equatable/equatable.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';

class ItemPageArgs extends Equatable {
  const ItemPageArgs({
    required this.item,
  });

  final Item item;

  @override
  List<Object?> get props => <Object?>[
    item,
  ];
}
