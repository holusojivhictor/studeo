import 'package:equatable/equatable.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';

class ItemPageArgs extends Equatable {
  const ItemPageArgs({
    required this.item,
    required this.index,
  });

  final Item item;
  final int index;

  @override
  List<Object?> get props => <Object?>[
    item,
    index,
  ];
}
