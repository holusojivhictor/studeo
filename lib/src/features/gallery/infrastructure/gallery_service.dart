import 'package:studeo/src/features/common/infrastructure/infrastructure.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:unsplash_client/unsplash_client.dart';

class GalleryService {
  GalleryService(this._unsplash);

  final UnsplashService _unsplash;

  UnsplashClient get client => _unsplash.client;

  Stream<Item> fetchItemsStream({required int page, int perPage = 10}) async* {
    final photos = await client.photos.list(
      page: page,
      perPage: perPage,
    ).goAndGet();

    for (final photo in photos) {
      final item = Item.fromPhoto(photo);

      yield item;
    }
  }
}
