import 'dart:convert';
import 'package:http/http.dart' as http;
import 'env_loader.dart';

class ApiService {
  final String baseUrl;
  final String apiKey;

  ApiService()
      : baseUrl = EnvLoader.getEnvVar('API_BASE_URL') ?? '',
        apiKey = EnvLoader.getEnvVar('CIVITAI_SECRET') ?? '';

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

  Future<List<dynamic>> fetchTags({int limit = 20, int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tags?limit=$limit&page=$page'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['items'] ?? [];
    } else {
      throw Exception('Failed to load tags');
    }
  }

  Future<List<dynamic>> fetchModelsByTag({
    required String tag,
    int limit = 20,
    int page = 1,
  }) async {
    final queryParameters = {
      'limit': '$limit',
      'page': '$page',
      'tag': tag,
    };

    final uri = Uri.https(
      baseUrl.replaceFirst('https://', ''),
      '/api/v1/models',
      queryParameters,
    );

    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['items'] ?? [];
    } else {
      throw Exception('Failed to load models');
    }
  }

  Future<List<dynamic>> fetchImages({
    int limit = 10,
    int? modelId,
    int? postId,
    int? modelVersionId,
    String? username,
    String? sort,
    String? period,
    bool? nsfw,
    int page = 1,
  }) async {
    final Map<String, String> queryParameters = {
      'limit': '$limit',
      'page': '$page',
      if (modelId != null) 'modelId': '$modelId',
      if (postId != null) 'postId': '$postId',
      if (modelVersionId != null) 'modelVersionId': '$modelVersionId',
      if (username != null && username.isNotEmpty) 'username': username,
      if (sort != null && sort.isNotEmpty) 'sort': sort,
      if (period != null && period.isNotEmpty) 'period': period,
      if (nsfw != null) 'nsfw': nsfw.toString(),
    };

    final uri = Uri.https(
      baseUrl.replaceFirst('https://', ''),
      '/api/v1/images',
      queryParameters,
    );

    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['items'] ?? [];
    } else {
      throw Exception('Failed to load images');
    }
  }

  /// Fetch images by tag using models and their versions
  Future<List<dynamic>> fetchImagesByTag({
    required String tag,
    int limit = 10,
    int page = 1,
  }) async {
    final models = await fetchModelsByTag(tag: tag, limit: limit, page: page);
    final List<dynamic> images = [];

    for (var model in models) {
      final modelId = model['id'];
      final modelImages = await fetchImages(limit: limit, modelId: modelId);
      images.addAll(modelImages);
    }

    return images;
  }
}
