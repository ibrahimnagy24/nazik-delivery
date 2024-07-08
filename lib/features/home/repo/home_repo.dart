import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/model/search_engine.dart';

import '../../../config/api_names.dart';
import '../../../network/network_layer.dart';

abstract class HomeRepo {
  static Future<dynamic> getHomeRequests(SearchEngine data) async {
    return await Network().request(ApiNames.requests,
        query: {
          "status": "in_libya_warehouse",
          "page": data.currentPage + 1,
          "limit": data.limit,
        },
        method: ServerMethods.GET,
        model: RequestsModel());
  }
}
