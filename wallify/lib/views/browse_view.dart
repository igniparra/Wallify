import 'package:flutter/material.dart';
import '../controllers/tag_controller.dart';
import '../controllers/image_controller.dart';
import '../models/tag_model.dart';

class BrowseView extends StatefulWidget {
  const BrowseView({super.key});

  @override
  BrowseViewState createState() => BrowseViewState();
}

class BrowseViewState extends State<BrowseView> {
  final TagController _tagController = TagController();
  final ImageController _imageController = ImageController();
  List<Tag> _tags = [];
  List<Map<String, dynamic>> _images = [];

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  Future<void> _fetchTags() async {
    final tags = await _tagController.fetchTags();
    setState(() {
      _tags = tags;
    });
  }

  Future<void> _fetchImagesByTag(String tag) async {
    final images = await _imageController.fetchImagesByTag(tag, limit: 5);
    setState(() {
      _images = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Tag Selector
          DropdownButton<String>(
            hint: const Text('Select Tag'),
            items: _tags.map((Tag tag) {
              return DropdownMenuItem<String>(
                value: tag.name,
                child: Text(tag.name),
              );
            }).toList(),
            onChanged: (String? selectedTag) {
              if (selectedTag != null) {
                _fetchImagesByTag(selectedTag);
              }
            },
          ),
          // Images List
          Expanded(
            child: ListView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                final image = _images[index];
                return ListTile(
                  leading: Image.network(
                    image['url'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text('Image ID: ${image['id']}'),
                  subtitle: Text('Posted by: ${image['username']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
