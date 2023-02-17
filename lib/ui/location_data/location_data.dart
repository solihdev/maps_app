import 'package:flutter/material.dart';
import 'package:mapping_app/data/models/lat_long.dart';
import 'package:mapping_app/data/repositories/geocoding_repository.dart';

class LocationDataListScreen extends StatefulWidget {
  const LocationDataListScreen({Key? key}) : super(key: key);

  @override
  State<LocationDataListScreen> createState() => _LocationDataListScreenState();
}

class _LocationDataListScreenState extends State<LocationDataListScreen> {
  Future<List<LocationModel>> getLocation() =>
      GeoCodingRepository().getLocation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location list"),
      ),
      body: FutureBuilder(
        future: getLocation(),
        builder: (context, AsyncSnapshot<List<LocationModel>> snapshot) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("isEmpty"),
            );
          }
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              LocationModel date = snapshot.data![index];
              return ListTile(
                title: Text(date.id.toString()),
                trailing: Column(
                  children: [
                    Text(date.longitude.toString()),
                    Text(date.lattitude.toString()),
                  ],
                ),
                subtitle: Text(date.dateTime.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
