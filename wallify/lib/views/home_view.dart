import 'package:flutter/material.dart';
import '../utils/api_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final ApiService _apiService = ApiService();
  List<dynamic> _images = [];
  bool _isLoading = false;
  List<bool> _selectedCategories = [true, false, false];

  @override
  void initState() {
    super.initState();
    _fetchLatestImages();
  }

  void _fetchImages({
    String? sort,
    bool? nsfw,
  }) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final images = await _apiService.fetchImages(
        sort: sort,
        nsfw: nsfw,
        limit: 10,
      );

      setState(() {
        _images = images;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _fetchLatestImages() {
    setState(() {
      _selectedCategories = [true, false, false];
    });
    _fetchImages(sort: 'Newest', nsfw: false);
  }

  void _fetchHottestImages() {
    setState(() {
      _selectedCategories = [false, true, false];
    });
    _fetchImages(sort: 'Most Reactions', nsfw: false);
  }

  void _fetchNSFWImages() {
    setState(() {
      _selectedCategories = [false, false, true];
    });
    _fetchImages(sort: 'Newest', nsfw: true);
  }

  void _viewImageFullscreen(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FullscreenImageView(imageUrl: imageUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Wallify!'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Toggle Buttons Group
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ToggleButtons(
              isSelected: _selectedCategories,
              onPressed: (int index) {
                if (index == 0) {
                  _fetchLatestImages();
                } else if (index == 1) {
                  _fetchHottestImages();
                } else {
                  _fetchNSFWImages();
                }
              },
              borderRadius: BorderRadius.circular(20),
              children: const [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('Latest'),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('Hottest'),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('NSFW'),
                ),
              ],
            ),
          ),
          // Images List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final image = _images[index];
                      return GestureDetector(
                        onTap: () => _viewImageFullscreen(image['url']),
                        child: Column(
                          children: [
                            Image.network(
                              image['url'],
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            ListTile(
                              title: Text('Posted by: ${image['username']}'),
                              subtitle: Text('Image ID: ${image['id']}'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class FullscreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullscreenImageView({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image View'),
        centerTitle: true,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
