import 'dart:convert';

class Payment {
  final String paymentId;
  final String method;
  final String status;
  final int amount;
  String? transactionDate;

  Payment({
    required this.paymentId,
    required this.method,
    required this.status,
    required this.amount,
   this.transactionDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['PaymentId'],
      method: json['Method'],
      status: json['Status'],
      amount: json['Amount'],
      transactionDate: json['TransactionDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PaymentId': paymentId,
      'Method': method,
      'Status': status,
      'Amount': amount  // 'TransactionDate': transactionDate,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}


class PaymentResponse {
  final String permitNo;
  final String status;
  final String orderId;
  final String transactionId;
  final String date;
  final double amount;
  final String paymentMode;

  PaymentResponse({
    required this.permitNo,
    required this.status,
    required this.orderId,
    required this.transactionId,
    required this.date,
    required this.amount,
    required this.paymentMode,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      permitNo: json['permitNo'],
      status: json['status'],
      orderId: json['orderId'],
      transactionId: json['transactionId'],
      date: json['date'],
      amount: json['amount'],
      paymentMode: json['paymentMode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'permitNo': permitNo,
      'status': status,
      'orderId': orderId,
      'transactionId': transactionId,
      'date': date,
      'amount': amount,
      'paymentMode': paymentMode,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}


