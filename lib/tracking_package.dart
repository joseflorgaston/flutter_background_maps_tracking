library tracking_package;

import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingMap extends StatefulWidget {
  const TrackingMap({
    super.key,
    required this.initialPosition,
    required this.backgroundMessage,
    this.backgroundIcon = '@mipmap/ic_launcher',
    required this.backgroundTitle, 
    required this.onTrack,
    this.zoom = 16.0,
    this.polylineColor = Colors.blue,
    required this.trackingDistanceFilter,
  });

  /// The initial position of the map's camera.
  final LatLng initialPosition;
  /// The title of the background notification
  final String backgroundTitle;
  /// The message of the background notification
  final String backgroundMessage;
  /// The icon of the background notification
  final String backgroundIcon;
  /// The map initial zoom level
  final double zoom;
  /// The tracking route color
  final Color polylineColor;
  /// Sets the tracking update distance per meter
  final double trackingDistanceFilter;
  /// Calls everytime the track updates
  /// @position returns the last location tracked
  final void Function(Location position) onTrack;

  @override
  State<TrackingMap> createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap> {
  LatLng get initialPosition => widget.initialPosition;
  String get backgroundTitle => widget.backgroundTitle;
  String get backgroundMessage => widget.backgroundMessage;
  String get backgroundIcon => widget.backgroundIcon;
  double get distanceFilter => widget.trackingDistanceFilter;
  double get zoom => widget.zoom;
  Color get polylineColor => widget.polylineColor;
  List<Marker> markers = [];
  Location? currentLatLng;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  
  @override
  void initState() {
    super.initState();
    _setBackgroundNotification();
    _getLocation();
  }

  @override
  void dispose() {
    BackgroundLocation.stopLocationService();
    super.dispose();
  }

  void _setBackgroundNotification() {
    BackgroundLocation.setAndroidNotification(
      title: backgroundTitle,
      message: backgroundMessage,
      icon: backgroundIcon,
    );
  }

  void _getLocation() {
    BackgroundLocation.startLocationService(distanceFilter: distanceFilter);
    BackgroundLocation.getLocationUpdates((Location location) {
      widget.onTrack.call(location);
      _setCameraPosition(location);
      setState(() => _addMarker(LatLng(location.latitude!, location.longitude!)));
    });
  }

  void _setCameraPosition(Location location) {
    if (_controller.isCompleted) {
      _controller.future.then(
        (value) => value.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(location.latitude!, location.longitude!),
              zoom: zoom,
            ),
          ),
        ),
      );
    }
  }

  Set<Polyline> _createPolylines() {
    Set<Polyline> polylines = <Polyline>{};
    for (int i = 0; i < markers.length - 1; i++) {
      polylines.add(
        Polyline(
          polylineId: PolylineId('polyline$i'),
          points: [markers[i].position, markers[i + 1].position],
          color: polylineColor,
          width: 5,
        ),
      );
    }
    return polylines;
  }

  void _addMarker(LatLng latLng) {
    markers.add(
      Marker(
        consumeTapEvents: true,
        markerId: MarkerId(latLng.toString()),
        position: latLng,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 16.0,
      ),
      onMapCreated: (controller) {
        if(_controller.isCompleted) return;
        _controller.complete(controller);
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      polylines: _createPolylines(),
    );
  }
}