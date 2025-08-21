import 'dart:convert';

class Payment {
  final String paymentId;
  final String method;
  final String status;
  final double amount;
  final double processingfee;
  int? deviceId;
  int? gateId;
  String? transactionDate;

  Payment({
    required this.paymentId,
    required this.method,
    required this.status,
    required this.amount,
    required this.processingfee,
    required this.deviceId,
    this.gateId,
    this.transactionDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['PaymentId'],
      method: json['Method'],
      status: json['Status'],
      amount: json['Amount'],
      processingfee: json['ProcessingFee'],
      deviceId: json['DeviceId'],
      gateId: json[' '],
      transactionDate: json['TransactionDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PaymentId': paymentId,
      'Method': method,
      'Status': status.toUpperCase(),
      'DeviceId': deviceId,
      'GateId': gateId,
      'ProcessingFee': processingfee,
      // 'Status': 'Success'.toUpperCase(),
      'Amount': amount // 'TransactionDate': transactionDate,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}

class PaymentResponse {
  final String? permitType;
  final String? permitNo;
  final String? applicantName;
  final String? applicantParent;
  final String? idNo;
  final String? dateOfIssue;
  final String? validUpto;
  final String? placeOfStay;
  final String? status;
  final String? orderId;
  final String? transactionId;
  final String? date;
  final double? amount;
  final double? processingfee;
  final String? paymentMode;

  PaymentResponse({
    required this.permitType,
    required this.permitNo,
    required this.applicantName,
    required this.applicantParent,
    required this.idNo,
    required this.dateOfIssue,
    required this.validUpto,
    required this.placeOfStay,
    required this.status,
    required this.orderId,
    required this.transactionId,
    required this.date,
    required this.amount,
    required this.processingfee,
    required this.paymentMode,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      permitType: json['permitType'],
      permitNo: json['permitNo'],
      applicantName: json['applicantName'],
      applicantParent: json['applicantParent'],
      idNo: json['idNo'],
      dateOfIssue: json['dateOfIssue'],
      validUpto: json['validUpto'],
      placeOfStay: json['placeofStay'], // Adjusting key to match JSON format
      status: json['status'],
      orderId: json['invoiceNo'],
      transactionId: json['transactionId'],
      date: json['date'],
      amount: (json['amount'] as num).toDouble(),
      processingfee: (json['processingFee'] as num).toDouble(),
      paymentMode: json['paymentMode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'permitType': permitType,
      'permitNo': permitNo,
      'applicantName': applicantName,
      'applicantParent': applicantParent,
      'idNo': idNo,
      'dateOfIssue': dateOfIssue,
      'validUpto': validUpto,
      'placeofStay': placeOfStay,
      'status': status?.toUpperCase(),
      'orderId': orderId,
      'transactionId': transactionId,
      'date': date,
      'amount': amount,
      'processingFee': processingfee,
      'paymentMode': paymentMode,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
