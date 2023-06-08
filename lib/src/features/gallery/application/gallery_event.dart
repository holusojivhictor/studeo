part of 'gallery_bloc.dart';

@freezed
class GalleryEvent with _$GalleryEvent {
  const factory GalleryEvent.init() = _Init;

  const factory GalleryEvent.imagesLoaded() = _ImagesLoaded;

  const factory GalleryEvent.refresh() = _Refresh;

  const factory GalleryEvent.loadMore() = _LoadMore;

  const factory GalleryEvent.imageLoaded({
    required Item item,
  }) = _ImageLoaded;
}
