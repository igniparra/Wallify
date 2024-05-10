import 'package:flutter/material.dart';
import '../controllers/preferences_controller.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({super.key});

  @override
  PreferencesViewState createState() => PreferencesViewState();
}

class PreferencesViewState extends State<PreferencesView> {
  final PreferencesController _preferencesController = PreferencesController();
  int _interval = 15;
  String _selectedTag = 'wallpapers';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final interval = await _preferencesController.getWallpaperInterval();
    final selectedTag = await _preferencesController.getSelectedTag();
    setState(() {
      _interval = interval;
      _selectedTag = selectedTag ?? 'wallpapers';
    });
  }

  Future<void> _savePreferences() async {
    await _preferencesController.setWallpaperInterval(_interval);
    await _preferencesController.setSelectedTag(_selectedTag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration:
                  const InputDecoration(labelText: 'Interval (minutes)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _interval = int.tryParse(value) ?? 15;
              },
              controller: TextEditingController(text: _interval.toString()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _savePreferences,
              child: const Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
