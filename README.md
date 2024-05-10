# Wallify

![Wallify Logo](https://example.com/wallify-logo.png)

**Wallify** is an Android app built with Flutter that allows you to change your device's wallpaper periodically, based on images fetched from the CivitAI API. Users can select their favorite tags to download images matching their preferences.

## Features

- Download and set images as wallpapers from CivitAI's extensive library.
- Schedule automatic wallpaper changes based on your chosen tags.
- Set wallpaper update intervals according to your preference.
- User-friendly interface with tag selection and customization options.

## Screenshots

![Main Screen](https://example.com/screenshots/main-screen.png)
![Tag Selection Screen](https://example.com/screenshots/tag-selection.png)

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code with Flutter/Dart plugins
- An Android device or emulator for testing

### Installation

1. **Clone the Repository**:

    ```bash
    git clone https://github.com/your-username/wallify.git
    cd wallify
    ```

2. **Install Dependencies**:

    ```bash
    flutter pub get
    ```

3. **Run the App**:

    ```bash
    flutter run
    ```

## Usage

1. Launch **Wallify** and choose your desired tags from the tag selection screen.
2. Set the interval at which you want the wallpapers to change.
3. Click "Save Settings & Start" to schedule automatic wallpaper changes.

## Project Structure

```
lib/
├── main.dart                   # Main app entry point
└── utils/
    ├── image_downloader.dart   # Utility to download images
    ├── image_fetcher.dart      # Fetches images from CivitAI API
    ├── tag_fetcher.dart        # Fetches tags from CivitAI API
    ├── wallpaper_changer.dart  # Sets the wallpaper
    └── wallpaper_scheduler.dart# Schedules periodic wallpaper changes
```

## Contributing

We welcome contributions from the community! If you would like to contribute, please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a Pull Request

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

- [CivitAI](https://civitai.com/) for providing the API.
- [WallpaperManagerFlutter](https://pub.dev/packages/wallpaper_manager_flutter) for the wallpaper setting functionality.
- [Workmanager](https://pub.dev/packages/workmanager) for the background task scheduling.

---

> **Wallify** - Your personalized wallpaper companion 🌟
