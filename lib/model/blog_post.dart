import 'dart:convert';

import 'package:http/http.dart' as http;
class BlogPost {
  final int id;
  final String title;
  final String content;
  final String excerpt;
  final int featuredMediaId;
  late Media featuredImage; // Media terpisah

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.featuredMediaId,
  });

  // Factory constructor untuk membuat objek BlogPost dari JSON
  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      title: json['title']['rendered'] ?? '',
      content: json['content']['rendered'] ?? '',
      excerpt: json['excerpt']['rendered'] ?? '',
      featuredMediaId: json['featured_media'] ?? 0,
    );
  }

  // Mengambil gambar berdasarkan featured_media
  Future<void> fetchFeaturedImage() async {
    this.featuredImage = await Media.fetchMedia(this.featuredMediaId);
  }
}


class Media {
  final int id;
  final String sourceUrl;

  Media({
    required this.id,
    required this.sourceUrl,
  });

  // Factory constructor untuk membuat objek Media dari JSON
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      sourceUrl: json['source_url'] ?? '',
    );
  }

  // Fetch image URL berdasarkan ID media
  static Future<Media> fetchMedia(int mediaId) async {
    final response = await http.get(Uri.parse('https://sampahkuid.ddns.net/wp-json/wp/v2/media/$mediaId'));

    if (response.statusCode == 200) {
      var mediaData = json.decode(response.body);
      return Media.fromJson(mediaData);
    } else {
      throw Exception('Failed to load media');
    }
  }
}
