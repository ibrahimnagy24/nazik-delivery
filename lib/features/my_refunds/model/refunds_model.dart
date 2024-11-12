import '../../../../network/mapper.dart';
import '../../../model/meta.dart';
import '../../../model/requests_model.dart';

class RefundsModel extends SingleMapper {
  int? status;
  String? message;
  List<RefundModel>? refunds;
  Meta? meta;

  RefundsModel({this.status, this.message, this.refunds, this.meta});

  RefundsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      refunds = [];
      json['data'].forEach((v) {
        refunds!.add(RefundModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['meta'] = meta?.toJson();
    if (refunds != null) {
      data['data'] = refunds!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return RefundsModel.fromJson(json);
  }
}

class RefundModel extends SingleMapper {
  int? id;
  String? refundNumber;
  RefundStatus? status;
  String? address, mobileNumber, deliveryRate;
  String? refundAmount;
  List<ItemModel>? items;

  RefundModel(
      {this.id,
      this.refundNumber,
      this.address,
      this.mobileNumber,
      this.deliveryRate,
      this.refundAmount,
      this.items,
      this.status});

  RefundModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refundNumber = json['number'];
    address = json['user_address'];
    mobileNumber = json['mobile_number'];
    deliveryRate = json['delivery_rate'];
    refundAmount = json['refund_amount']?.toString();
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
    data['number'] = refundNumber;
    data['refund_amount'] = refundAmount;
    data['mobile_number'] = mobileNumber;
    data['delivery_rate'] = deliveryRate;
    data['user_address'] = address;
    data['status'] = status?.index;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return RefundsModel.fromJson(json);
  }
}

enum RefundStatus {
  awaiting_money,
  awaiting_money_picked,
  money_picked,
  money_transit,

  approved,
  awaiting_pickup,
  in_transit_to_libya,
  arrived_libya,

  del_completed,
}

_getRequestStatus(status) {
  if (status == "approved") {
    return RefundStatus.approved;
  }
  if (status == "awaiting_money") {
    return RefundStatus.awaiting_money;
  }
  if (status == "awaiting_money_picked") {
    return RefundStatus.awaiting_money_picked;
  }
  if (status == "money_picked") {
    return RefundStatus.money_picked;
  }
  if (status == "money_transit") {
    return RefundStatus.money_transit;
  }
  if (status == "awaiting_pickup") {
    return RefundStatus.awaiting_pickup;
  }
  if (status == "in_transit_to_libya") {
    return RefundStatus.in_transit_to_libya;
  }
  if (status == "arrived_libya") {
    return RefundStatus.arrived_libya;
  }
  if (status == "del_completed") {
    return RefundStatus.del_completed;
  }
  if (status == "admin_completed") {
    return RefundStatus.del_completed;
  } else {
    return null;
  }
}
