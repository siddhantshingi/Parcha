# token_system

A Flutter project for the Token System application to manage crowds in Marketplaces.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Using the AsyncBuilder

Our application involves many HTTP POST and GET requests. Hence, there is a need to build Widgets asynchronously and add a Loading screen while network request completes in the background.  
For this purpose, a **AsyncBuilder** Widget has been added in lib/components folder, which uses the following three arguments:

```dart

// Arguments
//
// future {Future} : The Async Network request for whose response the
//                   WidgetBuilder must wait.
// builder {Function<dynamic>} : A function which is passed from the Parent
//                   Widget, to run on the return value that onReceiveJson
//                   returns (if any).
// onReceiveJson {Function<dynamic>} : A function, which is to be executed
//                   on the response of the Network request in the future
//                   argument. This function, if provided, must return a
//                   value which must be used by builder.

```

## Using TabNavigator

The `TabNavigator` class defined in lib/components/tab_navigator.dart is the basic element which can be used coupled with the BottomNavigationBar to provide separate Navigators for each tab on the BottomNavigationBar.

### Usage

1. Create a list of `GlobalKey<NavigatorState>` and `GlobalKey<TabNavigatorState>` for each tab on the BottomNavigationBar.
2. Build a list of `TabNavigator` objects for each tab on the BottomNavigationBar, using the above `GlobalKey`s. See home.dart#L49. Note that `TabNavigator` object also takes as argument the topmost widget to display.
3. Create a `Stack` of Offstage `TabNavigator` objects. Check home.dart#L79.
4. Pass along the `GlobalKey<TabNavigatorState>` to all subsequent screens (see choose_category.dart#L18) to use the same `TabNavigator` for navigation.
5. The `updateScreen()` funtion in `TabNavigator` updates the next screen to load when `Navigator.push()` is called. The `push()` function finally adds the new screen onto the Navigator.
6. Note: Enclose the body of a screen in a `WillPopScope` object while creating the `Stack` in step 3 to ensure that back button pops from the respective `NavigationStack`. See home.dart#L58.

## Server Configuration

Add the file lib/config/server_config.dart and add the URL to the server, as follows:

```dart
// server_config.dart file : All constants for the app, regarding the server go here.

const String server = 'http://8b1ef23b.ngrok.io/';
```

**Important**: This file shall not be committed to the repo.
