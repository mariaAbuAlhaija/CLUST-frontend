import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Address'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onTap: (LatLng tapLatLng) {
            setState(() {
              selectedLocation = tapLatLng;
            });
            _showLocationDetails(context, tapLatLng);
          },
          center: LatLng(37.7749, -122.4194), // Initial map center (San Francisco)
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if (selectedLocation != null)
            MarkerLayerOptions(
              markers: [
                Marker(
                  point: selectedLocation!,
                  builder: (ctx) => Icon(
                    Icons.location_pin,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _showLocationDetails(BuildContext context, LatLng point) async {
    final placemarks = await geocoding.placemarkFromCoordinates(
      point.latitude,
      point.longitude,
      localeIdentifier: 'en_US',
    );
    final placemark = placemarks.first;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selected Address'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Country: ${placemark.country}'),
              Text('Area: ${placemark.administrativeArea}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Save the selected address and navigate back
                // You can store the values in a state management solution or pass them to the previous screen.
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
