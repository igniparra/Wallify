import '../utils/api_service.dart';
import '../models/tag_model.dart';

class TagController {
  final ApiService _apiService = ApiService();

  Future<List<Tag>> fetchTags() async {
    final data = await _apiService.fetchTags();
    return data.map((tagJson) => Tag.fromJson(tagJson)).toList();
  }

  Future<List<dynamic>> fetchModelsByTag(String tag) async {
    return await _apiService.fetchModelsByTag(tag: tag);
  }
}
