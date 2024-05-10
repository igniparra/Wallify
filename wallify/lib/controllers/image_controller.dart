import '../utils/database_service.dart';
import '../utils/api_service.dart';

class ImageController {
  final DatabaseService _databaseService = DatabaseService.instance;
  final ApiService _apiService = ApiService();

  /// Add a favorite image to the local database
  Future<void> addFavoriteImage(String url, String tags, String path) async {
    await _databaseService.insertFavoriteImage({
      'url': url,
      'tags': tags,
      'path': path,
    });
  }

  /// Retrieve favorite images from the local database
  Future<List<Map<String, dynamic>>> getFavoriteImages() async {
    return await _databaseService.getFavoriteImages();
  }

  /// Remove a favorite image from the local database by ID
  Future<void> removeFavoriteImage(int id) async {
    await _databaseService.deleteFavoriteImage(id);
  }

  /// Fetch images by tag from the API
  Future<List<Map<String, dynamic>>> fetchImagesByTag(String tag,
      {int limit = 10}) async {
    return List<Map<String, dynamic>>.from(
        await _apiService.fetchImagesByTag(tag: tag, limit: limit));
  }
}
