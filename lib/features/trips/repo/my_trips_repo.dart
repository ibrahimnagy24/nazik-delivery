import 'package:dio/dio.dart';
import 'package:flutter_base/model/search_engine.dart';

import '../../../config/api_names.dart';
import '../../../network/network_layer.dart';
import '../model/trips_model.dart';

abstract class MyTripsRepo {
  static Future<dynamic> getTrips(
      {required SearchEngine data, required TripsStatus status}) async {
    return await Network().request(
      ApiNames.trips,
      query: {
        "status": status.name,
        "page": data.currentPage + 1,
        "limit": data.limit,
        "order[id]": "desc",
        "me": true
      },
      method: ServerMethods.GET,
      model: TripsModel(),
    );
  }

  static Future<Response> updateTripStatus(data) async {
    return await Network().request(
      ApiNames.updateTripStatus(data["id"]),
      body: FormData.fromMap(data),
      method: ServerMethods.POST,
    );
  }
}
