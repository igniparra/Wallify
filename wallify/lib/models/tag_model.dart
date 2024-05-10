class Tag {
  final String name;
  final int modelCount;
  final String link;

  Tag({required this.name, required this.modelCount, required this.link});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      modelCount: json['modelCount'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'modelCount': modelCount,
      'link': link,
    };
  }
}
