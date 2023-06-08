import 'package:studeo/src/features/common/infrastructure/infrastructure.dart';
import 'package:studeo/src/features/gallery/domain/models/models.dart';
import 'package:unsplash_client/unsplash_client.dart';

class GalleryService {
  GalleryService(this._unsplash);

  final UnsplashService _unsplash;

  UnsplashClient get client => _unsplash.client;

  static const int perPage = 10;

  Stream<Item> fetchItemsStream({required int page}) async* {
    final photos = await client.photos.list(page: page, perPage: page).goAndGet();
    for (final photo in photos) {
      final item = Item.fromPhoto(photo);

      yield item;
    }
  }
}
