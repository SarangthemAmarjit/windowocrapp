import 'package:intl/intl.dart';

class OtpResponse {
  final String status;
  final String? message;
  final String? referenceId;
  final String? transactionId;
  final String? error;
  final String? errorCode;
  final DateTime responseTimestamp;

  OtpResponse({
    required this.status,
    this.message,
    this.referenceId,
    this.transactionId,
    this.error,
    this.errorCode,
    required this.responseTimestamp,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      status: json['status'],
      message: json['message'],
      referenceId: json['reference_id'],
      transactionId: json['transaction_id'],
      error: json['error'],
      errorCode: json['error_code'],
      responseTimestamp: DateTime.parse(json['response_time_stamp']),
    );
  }

  String get formattedTimestamp {
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    return formatter.format(responseTimestamp);
  }
}
