import 'package:shared_preferences/shared_preferences.dart';

class PreferencesController {
  static const String keyInterval = 'wallpaper_interval';
  static const String keySelectedTag = 'selected_tag';

  Future<void> setWallpaperInterval(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyInterval, minutes);
  }

  Future<int> getWallpaperInterval() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyInterval) ?? 15;
  }

  Future<void> setSelectedTag(String tag) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keySelectedTag, tag);
  }

  Future<String?> getSelectedTag() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keySelectedTag);
  }
}
