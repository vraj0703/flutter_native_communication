# Flutter Native Communication

## Overview
The Flutter Native Communication project provides a communication channel between Flutter and native platforms, enabling seamless integration of native UI components with Flutter-based applications.

## Key Features
- Platform-specific implementations for Android and iOS
- Method channels for communication between Dart code and native platform
- Event-driven architecture for efficient handling of events from the native platform

## Tech Stack & Dependencies
- **Language:** Dart
- **Key Libraries/Frameworks:**
	+ Flutter
	+ Method Channel
	+ Equatable

## Getting Started

### Prerequisites
- Install Flutter on your machine
- Familiarity with Dart programming language and Flutter framework

### How to Run
1. Clone the repository
2. Open the project in your preferred IDE (e.g., Android Studio or Visual Studio Code)
3. Run the `flutter run` command in the terminal to start the app

## Codebase Structure
The codebase consists of several files, each serving a specific purpose:
- `flutter_native_communication.dart`: Provides the FlutterNativeCommunication class, which enables communication with the native platform.
- `flutter_native_communication_method_channel.dart`: Implements the method channel for communication between Dart and native platforms.
- `flutter_native_communication_platform_interface.dart`: Defines the FlutterNativeCommunicationPlatform interface, which is implemented by different platforms (e.g., Android and iOS).
- `flutter_native_communication_web.dart`: Provides a web implementation of the FlutterNativeCommunicationPlatform interface.
- `logger.dart`: Initializes the logger for the project.
- `typedefs.dart`: Defines type aliases used throughout the codebase.
- `unit_classes.dart`: Contains placeholder classes (Unit and None) used in the codebase.
- `native_event_channel.dart`: Implements the NativeEventChannel, which manages event handling and notification between Dart and native platforms.
- `entrypoint_queuer.dart`: Provides a mixin for implementing entry point queuing.
- `queuer.dart`: Implements the Queuer interface, which handles event queuing and processing.
- `entrypoint_bloc.dart`: Defines the EntrypointBloc class, which manages state and event handling for the Flutter Native Communication application.
- `entrypoint_event.dart`: Contains various event classes (EntrypointNative, EntrypointMethodCall, etc.) that are used in the codebase.
- `entrypoint_state.dart`: Defines the EntrypointState abstract class, which is used to represent different states of the application.

Note: The codebase includes several parts and files not mentioned here.