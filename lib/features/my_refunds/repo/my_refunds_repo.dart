import 'package:dio/dio.dart';

import '../../../config/api_names.dart';
import '../../../model/search_engine.dart';
import '../../../network/network_layer.dart';
import '../model/refunds_model.dart';

abstract class MyRefundRepo {
  static Future<dynamic> getMyRefund(
      {required SearchEngine data, required RefundStatus status}) async {
    return await Network().request(
      ApiNames.refunds,
      query: {
        "status": status.name,
        "page": data.currentPage + 1,
        "limit": data.limit,
        "order[id]": "desc",
      },
      method: ServerMethods.GET,
      model: RefundsModel(),
    );
  }



  static Future<dynamic> updateRefundStatus(data) async {
    return await Network().request(
      ApiNames.updateRefunds(data["id"]),
      body: FormData.fromMap(data),
      method: ServerMethods.POST,
    );
  }
}
