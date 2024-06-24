import '../../../../network/mapper.dart';
import 'meta.dart';

class RequestsModel extends SingleMapper {
  int? status;
  String? message;
  List<RequestModel>? requests;
  Meta? meta;

  RequestsModel({this.status, this.message, this.requests, this.meta});

  RequestsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      requests = [];
      json['data'].forEach((v) {
        requests!.add(RequestModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['meta'] = meta?.toJson();
    if (requests != null) {
      data['data'] = requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return RequestsModel.fromJson(json);
  }
}

class RequestModel extends SingleMapper {
  int? id;
  String? address, phoneNumber;
  RequestStatus? status;
  List<ItemModel>? items;

  RequestModel(
      {this.id, this.address, this.phoneNumber, this.items, this.status});

  RequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    if (json['items'] != null) {
      items = [];
      json['data'].forEach((v) {
        items!.add(ItemModel.fromJson(v));
      });
    }
    status = RequestStatus.values[json['status']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['status'] = status?.index;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return RequestsModel.fromJson(json);
  }
}

class ItemModel {
  int? id;
  String? name, price, color, size, quantity, link;
  bool? isSelected;

  ItemModel(
      {this.id,
      this.name,
      this.price,
      this.color,
      size,
      this.quantity,
      this.link});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price']?.toString();
    color = json['color']?.toString();
    size = json['size']?.toString();
    link = json['link']?.toString();
    quantity = json['quantity']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['color'] = color;
    data['size'] = size;
    data['quantity'] = quantity;
    data['link'] = link;
    return data;
  }
}

enum RequestStatus { inProgress, picked, done }
