# Flutter Native Communication

A plugin package managing communication between Flutter and native platforms (Android, iOS, etc.).

## Key Features

- **Platform Channels**: Abstracted method channels for native calls.
- **Web Support**: specialized implementation for web platform.
- **Architecture**: Clean separation of platform interface and implementation.

## Getting Started

### Prerequisites

- Flutter SDK

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_native_communication:
    git:
      url: https://github.com/vraj0703/flutter_native_communication.git
```

## Usage

Use the plugin instance to invoke native methods:

```dart
await FlutterNativeCommunicationPlatform.instance.getNativeVersion();
```

## Maintainers

Maintained by the core development team.
