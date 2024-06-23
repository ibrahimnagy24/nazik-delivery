import 'package:dio/dio.dart';
import 'package:flutter_base/model/search_engine.dart';

import '../../../config/api_names.dart';
import '../../../model/items_model.dart';
import '../../../network/network_layer.dart';

abstract class RequestsRepo {
  static Future<dynamic> getRequests(
      {required SearchEngine data, required ItemStatus status}) async {
    return await Network().request(
      ApiNames.requests,
      query: {
        "filter": status.name,
        "page": data.currentPage + 1,
        "limit": data.limit,
      },
      method: ServerMethods.GET,
      model: ItemsModel(),
    );
  }

  static Future<Response> deleteItem(id) async {
    return await Network().request(
      ApiNames.deleteItem,
      body: FormData.fromMap({
        "id": id,
      }),
      method: ServerMethods.POST,
    );
  }
}
