import 'package:flutter/material.dart';
import 'package:mapping_app/data/models/lat_long.dart';
import 'package:mapping_app/view_models/map_view_model.dart';
import 'package:provider/provider.dart';
import '../../data/api_service/api_service.dart';
import '../../data/repositories/geocoding_repository.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.latLong}) : super(key: key);

  final LatLong latLong;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          MapViewModel(geoCodingRepository: GeoCodingRepository(
              apiService: ApiService())),
      builder: (context, child) {
        return Scaffold(
          body: Consumer<MapViewModel>(
            builder: (context, viewModel, child) {
              return Center(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Map Screen: ${viewModel.addressText}",
                        style: const TextStyle(color: Colors.black,
                          fontSize: 27,),),
                      ElevatedButton(
                        onPressed: () {
                          context.read<MapViewModel>().fetchAddress(
                              widget.latLong);
                        },
                        child: const Text("Map"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
