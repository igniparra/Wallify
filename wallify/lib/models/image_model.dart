class ImageModel {
  final String url;
  final String tags;
  final String path;

  ImageModel({required this.url, required this.tags, required this.path});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'],
      tags: json['tags'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'tags': tags,
      'path': path,
    };
  }
}
