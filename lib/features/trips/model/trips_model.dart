import '../../../model/meta.dart';
import '../../../network/mapper.dart';

class TripsModel extends SingleMapper {
  int? status;
  String? message;
  List<TripModel>? trips;
  Meta? meta;

  TripsModel({this.status, this.message, this.trips, this.meta});

  TripsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      trips = [];
      json['data'].forEach((v) {
        trips!.add(TripModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['meta'] = meta?.toJson();
    if (trips != null) {
      data['data'] = trips!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return TripsModel.fromJson(json);
  }
}

class TripModel {
  int? id;
  String? name;
  String? number;
  String? status;
  List<int>? orders;

  TripModel({this.id, this.name, this.number, this.status, this.orders});

  TripModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    status = json['status'];
    orders = json['orders'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['status'] = status;
    data['orders'] = orders;
    return data;
  }
}

enum TripsStatus {
  awaiting_to_be_delivered,
  out_for_delivery,
  completed,
}
