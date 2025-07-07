// To parse this JSON data, do
//
//     final permitPriceModel = permitPriceModelFromJson(jsonString);

import 'dart:convert';

List<PermitPriceModel> permitPriceModelFromJson(String str) =>
    List<PermitPriceModel>.from(json.decode(str).map((x) => PermitPriceModel.fromJson(x)));

String permitPriceModelToJson(List<PermitPriceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PermitPriceModel {
  final int permitId;
  final String permitName;
  final double fee;
  final double? renewFee;
  final int validityDays;

  PermitPriceModel({
    required this.permitId,
    required this.permitName,
    required this.fee,
    required this.renewFee,
    required this.validityDays,
  });

  factory PermitPriceModel.fromJson(Map<String, dynamic> json) => PermitPriceModel(
        permitId: json["permitId"],
        permitName: json["permitName"],
        fee: json["fee"],
        renewFee: json["renewFee"] ?? 0.0,
        validityDays: json["validityDays"],
      );

  Map<String, dynamic> toJson() => {
        "permitId": permitId,
        "permitName": permitName,
        "fee": fee,
        "renewFee": renewFee!,
        "validityDays": validityDays,
      };
}
