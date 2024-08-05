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
  int? employeeId;
  String? address, mobileNumber, orderNumber;
  RequestStatus? status;
  double? deposit;
  List<ItemModel>? items;

  RequestModel(
      {this.id,
      this.employeeId,
      this.address,
      this.mobileNumber,
      this.orderNumber,
      this.deposit,
      this.items,
      this.status});

  RequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    address = json['user_address'];
    mobileNumber = json['mobile_number'];
    orderNumber = json['number'];
    deposit =
        json['deposit'] != null ? double.parse(json['deposit'].toString()) : 0;
    if (json['items'] != null) {
      items = <ItemModel>[];
      json['items'].forEach((v) {
        items!.add(ItemModel.fromJson(v));
      });
    }
    status = _getRequestStatus(json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['number'] = orderNumber;
    data['mobile_number'] = mobileNumber;
    data['user_address'] = address;
    data['deposit'] = deposit;
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

class ItemModel extends SingleMapper {
  int? id;
  String? image;
  String? title;
  String? city;
  String? link;
  String? categoryName;
  String? subCategoryName;
  String? brandName;
  String? color;
  String? size;
  String? quantity;
  String? price;
  String? note;
  int? orderId;
  String? number;
  String? createdAt;
  String? updatedAt;
  String? shipmentCompany;
  String? shipmentNumber;
  String? employeeId;
  String? orderNumber;
  String? purchaseMethod;

  ItemModel(
      {this.id,
      this.image,
      this.number,
      this.city,
      this.title,
      this.link,
      this.categoryName,
      this.subCategoryName,
      this.brandName,
      this.color,
      this.size,
      this.quantity,
      this.price,
      this.note,
      this.orderId,
      this.createdAt,
      this.updatedAt,
      this.shipmentCompany,
      this.shipmentNumber,
      this.employeeId,
      this.purchaseMethod,
      this.orderNumber});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number']?.toString();
    image = json['image'];
    city = json['city'];
    title = json['title'];
    link = json['link'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    brandName = json['brand_name'];
    color = json['color'];
    size = json['size'];
    quantity = json['quantity']?.toString();
    price = json['price']?.toString();
    note = json['note'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shipmentCompany = json['shipment_company']?.toString();
    shipmentNumber = json['shipment_number']?.toString();
    employeeId = json['employee_id']?.toString();
    orderNumber = json['order_number']?.toString();
    purchaseMethod = json['purchase_method '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['number'] = number;
    data['city'] = city;
    data['title'] = title;
    data['link'] = link;
    data['category_name'] = categoryName;
    data['sub_category_name'] = subCategoryName;
    data['brand_name'] = brandName;
    data['color'] = color;
    data['size'] = size;
    data['quantity'] = quantity;
    data['price'] = price?.toString();
    data['note'] = note;
    data['order_id'] = orderId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['shipment_company'] = shipmentCompany;
    data['shipment_number'] = shipmentNumber;
    data['employee_id'] = employeeId;
    data['purchase_method '] = purchaseMethod;
    data['order_number'] = orderNumber?.toString();
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return ItemModel.fromJson(json);
  }
}

enum RequestStatus { inProgress, outForDelivery, completed }

_getRequestStatus(status) {
  if (status == "in_libya_warehouse") {
    return RequestStatus.inProgress;
  }
  if (status == "deposit_payment_request") {
    return RequestStatus.inProgress;
  }
  if (status == "out_for_delivery") {
    return RequestStatus.outForDelivery;
  }
  if (status == "completed") {
    return RequestStatus.completed;
  } else {
    return null;
  }
}
