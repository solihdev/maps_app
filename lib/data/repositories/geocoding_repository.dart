import 'package:mapping_app/data/api_service/api_service.dart';
import 'package:mapping_app/data/models/lat_long.dart';

class GeoCodingRepository {
  GeoCodingRepository({required this.apiService});

  final ApiService apiService;

  Future<String> getAddress(LatLong latLong, String kind) => apiService.getLocationName(
        geoCodeText: "${latLong.longitude},${latLong.lattitude}",
        kind: kind,
      );
}
