# movieapp

This is a simple app that consume api from Themoviedb.org

Features and Function that used:

- Bloc State Management
- Dio
- Infinite Scroll
- Slider View
- Youtube Player
- HiveCached
- Get_it Dependency injection

# Getting started

Clone this project from this github and it will create the necessarry platform files such as `ios/`, `android/`,

# Development

Usually you will open the template in your favorite IDE, like Android Studio
or Visual Studio Code, and from there you will be able to run the game in debug
mode directly. Usually by pressing a green play button.

To run the game in debug mode directly from the terminal you can do:

    flutter run

This assumes you have an Android emulator, iOS Simulator, or an attached
physical device.

## Code organization

Code is organized in a cleaning code base.
In `lib/`, you'll therefore find directories for flutter code

```
lib
├── bloc
├── core
├── data
├── models
├── ui
├── util
└── main.dart
```

The state management used bLoc State Management.

## Building for production

To build the app for iOS (and open Xcode when finished):

```shell
flutter build ipa && open build/ios/archive/Runner.xcarchive
```

To build the app for Android (and open the folder with the bundle when finished):

```shell
flutter build appbundle && open build/app/outputs/bundle/release
```
