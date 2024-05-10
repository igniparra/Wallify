class UserPreferences {
  final int wallpaperInterval;
  final String selectedTag;

  UserPreferences({required this.wallpaperInterval, required this.selectedTag});

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      wallpaperInterval: json['wallpaperInterval'],
      selectedTag: json['selectedTag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wallpaperInterval': wallpaperInterval,
      'selectedTag': selectedTag,
    };
  }
}
