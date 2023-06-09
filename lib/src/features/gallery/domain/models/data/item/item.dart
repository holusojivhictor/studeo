import 'package:equatable/equatable.dart';
import 'package:studeo/src/extensions/extensions.dart';
import 'package:unsplash_client/unsplash_client.dart';

class Item extends Equatable {
  const Item({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.urls,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.downloads,
    required this.likes,
    required this.description,
    required this.links,
    required this.tags,
  });

  Item.fromPhoto(Photo photo)
      : id = photo.id,
        createdAt = photo.createdAt,
        updatedAt = photo.updatedAt,
        urls = photo.urls,
        width = photo.width,
        height = photo.height,
        color = photo.color,
        blurHash = photo.blurHash,
        downloads = photo.downloads,
        likes = photo.likes,
        description = photo.description,
        links = photo.links,
        tags = photo.tags;

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        createdAt = DateTime.parse(json['created_at'] as String),
        updatedAt = DateTime.parse(json['updated_at'] as String),
        urls = (json['urls'] as Map<String, dynamic>).let(PhotoUrls.fromJson),
        width = json['width'] as int,
        height = json['height'] as int,
        color = json['color'] as String,
        blurHash = json['blur_hash'] as String?,
        downloads = json['downloads'] as int?,
        likes = json['likes'] as int,
        description = json['description'] as String?,
        links =
            (json['links'] as Map<String, dynamic>).let(PhotoLinks.fromJson),
        tags = (json['tags'] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>()
            .map(Tag.fromJson)
            .toList();

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PhotoUrls urls;
  final int width;
  final int height;
  final String color;
  final String? blurHash;
  final int? downloads;
  final int likes;
  final String? description;
  final PhotoLinks links;
  final List<Tag>? tags;

  String get regular => urls.regular.toString();

  String get full => urls.full.toString();

  double get ratio => width / height;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'urls': urls.toJson(),
      'width': width,
      'height': height,
      'color': color,
      'blur_hash': blurHash,
      'downloads': downloads,
      'likes': likes,
      'description': description,
      'links': links.toJson(),
      'tags': tags?.map((tag) => tag.toJson()).toList(),
    };
  }

  @override
  String toString() => 'Item $id';

  @override
  List<Object?> get props => [
    id,
    createdAt,
    updatedAt,
    urls,
    width,
    height,
    color,
    blurHash,
    downloads,
    likes,
    description,
    links,
    tags,
  ];
}
