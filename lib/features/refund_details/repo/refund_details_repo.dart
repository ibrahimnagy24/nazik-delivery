import 'package:dio/dio.dart';

import '../../../config/api_names.dart';
import '../../../network/network_layer.dart';

abstract class RefundDetailsRepo {
  static Future<dynamic> getRefundDetails(id) async {
    return await Network().request(
      ApiNames.refundDetails(id),
      method: ServerMethods.GET,
    );
  }

  static Future<dynamic> refund(data) async {
    return await Network().request(
      ApiNames.assignRefund,
      body: FormData.fromMap(data),
      method: ServerMethods.POST,
    );
  }
}
