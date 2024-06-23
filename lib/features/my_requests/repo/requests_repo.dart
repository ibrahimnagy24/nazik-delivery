import 'package:dio/dio.dart';
import 'package:flutter_base/model/search_engine.dart';

import '../../../config/api_names.dart';
import '../../../model/items_model.dart';
import '../../../network/network_layer.dart';

abstract class MyRequestsRepo {
  static Future<dynamic> getRequests(
      {required SearchEngine data, required RequestStatus status}) async {
    return await Network().request(
      ApiNames.requests,
      query: {
        "filter": status.name,
        "page": data.currentPage + 1,
        "limit": data.limit,
      },
      method: ServerMethods.GET,
      model: RequestsModel(),
    );
  }

  static Future<Response> cancelRequest(id) async {
    return await Network().request(
      ApiNames.cancelItem,
      body: FormData.fromMap({
        "id": id,
      }),
      method: ServerMethods.POST,
    );
  }

  static Future<Response> updateRequestStatus(data) async {
    return await Network().request(
      ApiNames.cancelItem,
      body: FormData.fromMap(data),
      method: ServerMethods.POST,
    );
  }
}
