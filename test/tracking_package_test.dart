import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:mockito/mockito.dart';
import 'package:flutter_background_maps_tracking/tracking_package.dart';

// Mock Location class to mock location data
class MockLocation extends Mock implements location.Location {}

void main() {
  group('TrackingMap Widget', () {
    testWidgets('Renders GoogleMap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TrackingMap(
            initialPosition: const LatLng(-25.29376, -57.60343),
            backgroundTitle: 'Title',
            backgroundMessage: 'Message',
            onTrack: (locationData) {},
            trackingDistanceFilter: 10.0,
          ),
        ),
      );

      expect(find.byType(GoogleMap), findsOneWidget);
    });  
  });
}
