import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/model/search_engine.dart';

import '../../../config/api_names.dart';
import '../../../network/network_layer.dart';
import '../../my_refunds/model/refunds_model.dart';

abstract class HomeRepo {
  static Future<dynamic> getHomePurchasesRequests(SearchEngine data) async {
    return await Network().request(ApiNames.requests,
        query: {
          "delivery_app": data.query,
          "page": data.currentPage + 1,
          "limit": data.limit,
          "order[id]": "desc",
        },
        method: ServerMethods.GET,
        model: RequestsModel());
  }

  static Future<dynamic> getHomeRefundsRequests(SearchEngine data) async {
    return await Network().request(ApiNames.refunds,
        query: {
          "status": data.query,
          "page": data.currentPage + 1,
          "limit": data.limit,
          "order[id]": "desc",
        },
        method: ServerMethods.GET,
        model: RefundsModel());
  }
}
