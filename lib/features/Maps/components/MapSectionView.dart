import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapSectionView extends StatefulWidget {
  final double lat;
  final double long;

  const MapSectionView({
    super.key,
    required this.lat,
    required this.long,
  });

  @override
  State<MapSectionView> createState() => _MapSectionViewState();
}

class _MapSectionViewState extends State<MapSectionView> {
  late MapboxMap _mapboxMap;
  late PointAnnotationManager _annotationManager;

  final String _mapboxToken =
      'pk.eyJ1IjoicHJvZmV4eG9yNDA0IiwiYSI6ImNtZGg3bndzdTAwZXQyeHF2MXdpbGdweHAifQ.LvIS-l4S70TH9zr6yELRew';

  @override
  void initState() {
    super.initState();
    MapboxOptions.setAccessToken(_mapboxToken);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: MapWidget(
          key: ValueKey('${widget.lat}_${widget.long}'),
          cameraOptions: CameraOptions(
            center: Point(coordinates: Position(widget.long, widget.lat)),
            zoom: 5.5,
            pitch: 30.0,
          ),
          onMapCreated: _onMapCreated,
          gestureRecognizers: {
            Factory(() => EagerGestureRecognizer()),
          },
          styleUri: MapboxStyles.MAPBOX_STREETS,
        ),
      ),
    );
  }

  void _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    _annotationManager =
    await _mapboxMap.annotations.createPointAnnotationManager();

    _addMarkers();
  }

  void _addMarkers() async {
    final List<PointAnnotationOptions> options = [
      _buildMarker(widget.lat, widget.long),
      _buildMarker(widget.lat + 0.1, widget.long + 0.1),
      _buildMarker(widget.lat - 0.15, widget.long + 0.05),
      _buildMarker(widget.lat + 0.2, widget.long - 0.1),
      _buildMarker(widget.lat - 0.1, widget.long - 0.1),
    ];

    await _annotationManager.createMulti(options);
  }

  PointAnnotationOptions _buildMarker(double lat, double long) {
    return PointAnnotationOptions(
      geometry: Point(coordinates: Position(long, lat)),
      iconImage: "marker-15", // Default mapbox marker
      iconSize: 2.5,
    );
  }
}

