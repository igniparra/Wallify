import 'dart:convert';
import 'dart:developer';
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

  /// Fetch all tags
  Future<List<dynamic>> fetchTags({int page = 1}) async {
    final uri = Uri.parse('$baseUrl/tags?page=$page');

    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['items'] ?? [];
    } else {
      log('Failed to load tags: ${response.body}');
      throw Exception('Failed to load tags');
    }
  }

  /// Fetch models by tag
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

    final uri = Uri.parse('$baseUrl/models?${_mapToQuery(queryParameters)}');

    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['items'] ?? [];
    } else {
      log('Failed to load models: ${response.body}');
      throw Exception('Failed to load models');
    }
  }

  /// Fetch images with various optional filters
  Future<List<dynamic>> fetchImages({
    int limit = 10,
    int? modelId,
    int? postId,
    int? modelVersionId,
    String? username,
    String? sort,
    String? period = 'AllTime',
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
      if (nsfw != null) 'nsfw': nsfw ? 'X' : 'None',
    };

    final uri = Uri.parse('$baseUrl/images?${_mapToQuery(queryParameters)}');

    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['items'] ?? [];
    } else {
      log('Failed to load images: ${response.body}');
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

  /// Helper function to convert map to query string
  String _mapToQuery(Map<String, String> queryParams) {
    return queryParams.entries
        .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
        .join('&');
  }
}
