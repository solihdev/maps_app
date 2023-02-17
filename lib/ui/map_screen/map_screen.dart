import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapping_app/data/models/lat_long.dart';
import 'package:mapping_app/ui/location_data/location_data.dart';
import 'package:mapping_app/view_models/map_view_model.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/geocoding_repository.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.latLong}) : super(key: key);

  final LocationModel latLong;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          MapViewModel(geoCodingRepository: GeoCodingRepository()),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Map Screen"), actions: [
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<MapViewModel>();
                }),
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LocationDataListScreen()));
              },
            ),
          ]),
          body: Consumer<MapViewModel>(
            builder: (context, viewModel, child) {
              return SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 85,
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  onMapCreated: (GoogleMapController controller) {},
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          widget.latLong.longitude, widget.latLong.lattitude),
                      zoom: 16),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
