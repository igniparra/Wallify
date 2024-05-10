import 'package:flutter/material.dart';
import '../controllers/tag_controller.dart';
import '../models/tag_model.dart';

class BrowseView extends StatefulWidget {
  const BrowseView({super.key});

  @override
  BrowseViewState createState() => BrowseViewState();
}

class BrowseViewState extends State<BrowseView> {
  final TagController _tagController = TagController();
  List<Tag> _tags = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _tags.length,
        itemBuilder: (context, index) {
          final tag = _tags[index];
          return ListTile(
            title: Text(tag.name),
            subtitle: Text('Models: ${tag.modelCount}'),
          );
        },
      ),
    );
  }
}
