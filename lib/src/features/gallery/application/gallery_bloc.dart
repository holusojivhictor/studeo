import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/infrastructure/gallery_service.dart';

part 'gallery_bloc.freezed.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc(this._galleryService) : super(const GalleryState.init()) {
    on<_Init>(_onInit);
    on<_Refresh>(_onRefresh);
    on<_LoadMore>(_onLoadMore);
    on<_ImageLoaded>(_onImageLoaded);
    on<_ImagesLoaded>(_onImagesLoaded);
  }

  final GalleryService _galleryService;
  static const int _pageSize = 10;

  Future<void> _onInit(_Init event, Emitter<GalleryState> emit) async {
    emit(
      const GalleryState.init().copyWith(
        currentPageSize: _pageSize,
      ),
    );
    await _loadImages(emit: emit);
  }

  Future<void> _loadImages({
    required Emitter<GalleryState> emit,
  }) async {
    emit(state.copyWithCurrentPageUpdated(to: 1));

    _galleryService
        .fetchItemsStream(
          page: state.currentPage,
          perPage: state.currentPageSize,
        )
        .listen((Item item) => add(GalleryEvent.imageLoaded(item: item)))
        .onDone(() => add(const GalleryEvent.imagesLoaded()));
  }

  Future<void> _onRefresh(_Refresh event, Emitter<GalleryState> emit) async {
    emit(state.copyWithStatusUpdated(to: ImagesStatus.loading));

    emit(state.copyWithRefreshed());
    await _loadImages(emit: emit);
  }

  void _onLoadMore(_LoadMore event, Emitter<GalleryState> emit) {
    emit(state.copyWithStatusUpdated(to: ImagesStatus.loading));

    final currentPage = state.currentPage;
    emit(state.copyWithCurrentPageUpdated(to: currentPage + 1));

    _galleryService
        .fetchItemsStream(page: state.currentPage)
        .listen((Item item) => add(GalleryEvent.imageLoaded(item: item)))
        .onDone(() => add(const GalleryEvent.imagesLoaded()));
  }

  void _onImageLoaded(_ImageLoaded event, Emitter<GalleryState> emit) {
    emit(state.copyWithItemAdded(item: event.item));
  }

  void _onImagesLoaded(_ImagesLoaded event, Emitter<GalleryState> emit) {
    emit(state.copyWithStatusUpdated(to: ImagesStatus.loaded));
  }
}
