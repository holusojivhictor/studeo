import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:studeo/src/features/gallery/application/gallery_bloc.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:studeo/src/features/gallery/infrastructure/gallery_service.dart';

class MockGalleryService extends Mock implements GalleryService {}

void main() {
  const page = 1;
  const pageSize = 20;

  final list = <Item>[];

  GalleryBloc galleryBloc() {
    final galleryService = MockGalleryService();
    when(
      () => galleryService.fetchItemsStream(page: page, perPage: pageSize),
    ).thenAnswer((_) => items);

    return GalleryBloc(galleryService);
  }

  test('Initial state', () {
    expect(galleryBloc().state, const GalleryState.init());
  });

  blocTest<GalleryBloc, GalleryState>(
    'On initial load',
    build: galleryBloc,
    act: (bloc) => bloc.add(const GalleryEvent.init()),
    setUp: () => items.listen(list.add),
    skip: 3,
    expect: () {
      return <GalleryState>[
        const GalleryState.init().copyWith(
          items: list,
          status: ImagesStatus.loaded,
          currentPage: page,
          currentPageSize: pageSize,
        ),
      ];
    },
  );

  blocTest<GalleryBloc, GalleryState>(
    'On refresh',
    build: galleryBloc,
    act: (bloc) => bloc
      ..add(const GalleryEvent.init())
      ..add(const GalleryEvent.refresh()),
    setUp: () => items.listen(list.add),
    skip: 7,
    expect: () {
      return <GalleryState>[
        const GalleryState.init().copyWith(
          items: list,
          status: ImagesStatus.loaded,
          currentPage: page,
          currentPageSize: pageSize,
        ),
      ];
    },
  );
}

final items = Stream<Item>.fromIterable([
  Item.empty(),
]);
