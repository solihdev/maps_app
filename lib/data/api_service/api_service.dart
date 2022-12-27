import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapping_app/data/geocoding/geocoding.dart';
import '../../utils/constants.dart';
import 'api_client.dart';

class ApiService extends ApiClient {
  Future<String> getLocationName(String geoCodeText) async {
    try {
      late Response response;
      Map<String, String> queryParams = {
        'api': mapApiKey,
        'geocode': geoCodeText,
        'lang': 'uz_Uz',
        'format': 'json',
        'kind': 'house',
        'rspn': '1',
        'result': '1',
      };
      debugPrint("QueryParams>>>>>>>>>$queryParams");
      response = await dio.get(
        "${dio.options.baseUrl}/",
        queryParameters: queryParams,
      );
      String text = '';
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        Geocoding geocoding = Geocoding.fromJson(response.data);
        if (geocoding.response.geoObjectCollection.featureMember.isNotEmpty) {
          text = geocoding.response.geoObjectCollection.featureMember[0]
              .geoObject.metaDataProperty.geocoderMetaData.text;
          debugPrint("text>>>>>>>>>>> $text");
        } else {
          text = "Aniqlanmagan hudud";
        }
        return text;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}