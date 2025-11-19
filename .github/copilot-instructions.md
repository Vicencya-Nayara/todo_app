# AI Coding Agent Instructions for `flutter_application_1`

Welcome to the `flutter_application_1` codebase! This document provides essential guidance for AI coding agents to be productive in this project. It covers the architecture, workflows, and conventions specific to this Flutter application.

---

## Project Overview

This is a Flutter-based cross-platform application. The project structure supports multiple platforms, including Android, iOS, web, Windows, macOS, and Linux. Key directories include:

- `lib/`: Contains the main Dart code for the application. Start with `main.dart`.
- `android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/`: Platform-specific configurations and code.
- `test/`: Contains test files, such as `widget_test.dart`.

## Architecture

The application follows the standard Flutter architecture:

- **UI Layer**: Defined in `lib/main.dart` and other Dart files in `lib/`.
- **Platform-Specific Code**: Located in respective platform directories (e.g., `android/app/src/main/`, `ios/Runner/`).
- **Assets**: Managed in `pubspec.yaml` and stored in platform-specific asset folders (e.g., `ios/Runner/Assets.xcassets/`).

## Developer Workflows

### Building the Application
- **Flutter Build**: Run `flutter build <platform>` (e.g., `flutter build apk` for Android).
- **Platform-Specific Builds**: Use Gradle for Android (`gradlew assembleDebug`) or Xcode for iOS.

### Running the Application
- Use `flutter run` to launch the app on a connected device or emulator.
- Specify a platform with `flutter run -d <device>`.

### Testing
- Run all tests: `flutter test`.
- Run a specific test file: `flutter test test/widget_test.dart`.

### Debugging
- Use `flutter logs` to view runtime logs.
- For platform-specific debugging, use Android Studio (Android) or Xcode (iOS).

## Conventions and Patterns

- **State Management**: This project does not specify a state management solution. Follow the Flutter community's best practices.
- **Testing**: Tests are located in `test/`. Use `flutter_test` for widget and integration tests.
- **Assets**: Declare assets in `pubspec.yaml` under the `assets` section.

## External Dependencies

Dependencies are managed in `pubspec.yaml`. Run `flutter pub get` to install them. Key dependencies include:

- `flutter`: The core Flutter SDK.

## Integration Points

- **Platform Channels**: For communication between Dart and native code, use platform channels. Refer to `android/app/src/main/` and `ios/Runner/` for examples.
- **Generated Code**: Files like `GeneratedPluginRegistrant` are auto-generated. Avoid manual edits.

---

## Examples

### Adding a New Dependency
1. Add the dependency to `pubspec.yaml`:
   ```yaml
   dependencies:
     new_package: ^1.0.0
   ```
2. Run `flutter pub get`.

### Running a Widget Test
1. Open `test/widget_test.dart`.
2. Run the test:
   ```bash
   flutter test test/widget_test.dart
   ```

---

For further assistance, refer to the [Flutter documentation](https://docs.flutter.dev/).