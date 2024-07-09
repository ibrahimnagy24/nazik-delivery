import 'package:dio/dio.dart';
import 'package:flutter_base/bloc/user_bloc.dart';
import 'package:flutter_base/model/search_engine.dart';

import '../../../config/api_names.dart';
import '../../../model/requests_model.dart';
import '../../../network/network_layer.dart';

abstract class MyRequestsRepo {
  static Future<dynamic> getRequests(
      {required SearchEngine data, required RequestStatus status}) async {
    return await Network().request(
      ApiNames.requests,
      query: {
        "status": status == RequestStatus.inProgress
            ? status.name
            : status == RequestStatus.outForDelivery
                ? "out_for_delivery"
                : status.name,
        "employee_id": UserBloc.instance.user?.id,
        "page": data.currentPage + 1,
        "limit": data.limit,
      },
      method: ServerMethods.GET,
      model: RequestsModel(),
    );
  }

  static Future<dynamic> unAssignRequest(id) async {
    return await Network()
        .request(ApiNames.unAssignRequest(id), method: ServerMethods.POST);
  }

  static Future<Response> updateRequestStatus(data) async {
    return await Network().request(
      ApiNames.updateRequestStatus(data["id"]),
      body: FormData.fromMap(data),
      method: ServerMethods.POST,
    );
  }
}
