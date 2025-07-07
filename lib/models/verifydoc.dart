import 'dart:convert';

VerifydocModel verifydocModelFromJson(String str) => VerifydocModel.fromJson(json.decode(str));

String verifydocModelToJson(VerifydocModel data) => json.encode(data.toJson());

class VerifydocModel {
  final String applicationId;

  VerifydocModel({
    required this.applicationId,
  });

  factory VerifydocModel.fromJson(Map<String, dynamic> json) => VerifydocModel(
        applicationId: json["applicationId"],
      );

  Map<String, dynamic> toJson() => {
        "applicationId": applicationId,
      };
}
