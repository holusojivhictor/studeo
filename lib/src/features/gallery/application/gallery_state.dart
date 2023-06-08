part of 'gallery_bloc.dart';

enum ImagesStatus {
  initial,
  loading,
  loaded,
}

class GalleryState extends Equatable {
  const GalleryState({
    required this.items,
    required this.status,
    required this.currentPage,
    required this.currentPageSize,
  });

  const GalleryState.init({
    this.items = const <Item>[],
    this.status = ImagesStatus.initial,
    this.currentPage = 0,
  }) : currentPageSize = 10;

  final List<Item> items;
  final ImagesStatus status;
  final int currentPage;
  final int currentPageSize;

  GalleryState copyWith({
    List<Item>? items,
    ImagesStatus? status,
    int? currentPage,
    int? currentPageSize,
  }) {
    return GalleryState(
      items: items ?? this.items,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      currentPageSize: currentPageSize ?? this.currentPageSize,
    );
  }

  GalleryState copyWithItemAdded({
    required Item item,
  }) {
    final newList = List<Item>.from(items)..add(item);
    return copyWith(
      items: newList,
    );
  }

  GalleryState copyWithStatusUpdated({
    required ImagesStatus to,
  }) {
    return copyWith(
      status: to,
    );
  }

  GalleryState copyWithCurrentPageUpdated({
    required int to,
  }) {
    return copyWith(
      currentPage: to,
    );
  }

  GalleryState copyWithRefreshed() {
    return copyWith(
      items: <Item>[],
      status: ImagesStatus.loading,
      currentPage: 0,
    );
  }

  @override
  List<Object?> get props => [
    items,
    status,
    currentPage,
    currentPageSize,
  ];
}
