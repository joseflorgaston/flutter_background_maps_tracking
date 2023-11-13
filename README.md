<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

The flutter_background_maps_tracking package is a powerful Flutter solution designed for seamlessly tracking a user's movement on a Google Maps interface, even when the application is running in the background. This package leverages the capabilities of Google Maps and Flutter's robust framework to provide a smooth and accurate tracking experience..

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

Get an API key at https://cloud.google.com/maps-platform/.

Enable Google Map SDK for each platform.

Go to Google Developers Console.
Choose the project that you want to enable Google Maps on.
Select the navigation menu and then select "Google Maps".
Select "APIs" under the Google Maps menu.
To enable Google Maps for Android, select "Maps SDK for Android" in the "Additional APIs" section, then select "ENABLE".
To enable Google Maps for iOS, select "Maps SDK for iOS" in the "Additional APIs" section, then select "ENABLE".
To enable Google Maps for Web, enable the "Maps JavaScript API".
Make sure the APIs you enabled are under the "Enabled APIs" section.
For more details, see Getting started with Google Maps Platform.

Android 

Set the minSdkVersion in android/app/build.gradle:
android {
    defaultConfig {
        minSdkVersion 20
    }
}
This means that app will only be available for users that run Android SDK 20 or higher.

Specify your API key in the application manifest android/app/src/main/AndroidManifest.xml:
<manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>

iOS 

To set up, specify your API key in the application delegate ios/Runner/AppDelegate.m:

#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"YOUR KEY HERE"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end
Or in your swift code, specify your API key in the application delegate ios/Runner/AppDelegate.swift:

import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR KEY HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}.

## Usage

To use this widget, simply include it in your Flutter application and provide
the required parameters.

```dart
 TrackingMap(
   initialPosition: LatLng(37.7749, -122.4194),
   backgroundTitle: 'Tracking in Progress',
   backgroundMessage: 'Your location is being tracked in the background.',
   onTrack: (Location position) {
     // Handle the location update
   },
   trackingDistanceFilter: 10.0,
 )
 ```

 ## Parameters

 - `initialPosition`: The initial position of the map's camera.
 - `backgroundTitle`: The title of the background notification.
 - `backgroundMessage`: The message of the background notification.
 - `backgroundIcon`: The icon of the background notification.
 - `zoom`: The map initial zoom level.
 - `polylineColor`: The tracking route color.
 - `trackingDistanceFilter`: Sets the tracking update distance per meter.
 - `onTrack`: Callback function that is called every time the location is updated.

 ## Example

 ```dart
 TrackingMap(
   initialPosition: LatLng(37.7749, -122.4194),
   backgroundTitle: 'Tracking in Progress',
   backgroundMessage: 'Your location is being tracked in the background.',
   onTrack: (Location position) {
     print('Location Update: ${position.latitude}, ${position.longitude}');
   },
   trackingDistanceFilter: 10.0,
)
```

## Additional information

- **Contributing**: We welcome contributions! Feel free to open issues or pull requests
   on our [GitHub repository](https://github.com/your_username/your_tracking_package).

- **Issues**: If you encounter any issues or have suggestions for improvements,
   please [file an issue](https://github.com/your_username/your_tracking_package/issues).

- **Contact**: For further information or inquiries, you can reach out to us at
   [your_email@example.com](mailto:your_email@example.com).

- **License**: This package is released under the [MIT License](https://opensource.org/licenses/MIT).
See the [LICENSE](https://github.com/your_username/your_tracking_package/blob/main/LICENSE) file for details.