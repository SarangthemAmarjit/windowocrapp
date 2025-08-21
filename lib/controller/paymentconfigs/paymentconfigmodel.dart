import 'package:camera_windows_example/cons/constant.dart';

class PaymentConfig {
  // Mandatory fields
  final String login;
  final String password;
  final String prodId;
  final String requestHashKey;
  final String responseHashKey;
  final String requestEncryptionKey;
  final String responseDecryptionKey;
  final String clientCode;
  final String txnCurr;
  final String mccCode;
  final String merchType;

  // Optional fields
  final String custAcc;
  final String udf1;
  final String udf2;
  final String udf3;
  final String udf4;
  final String udf5;

  // Mode (uat/live)
  final String mode;
  static String req_EncKeyuat = 'A4476C2062FFA58980DC8F79EB6A799E';
  static String req_Saltuat = 'A4476C2062FFA58980DC8F79EB6A799E';
  static String res_DecKeyuat = '75AEF0FA1B94B3C10D4F5B268F757F11';
  static String res_Saltuat = '75AEF0FA1B94B3C10D4F5B268F757F11';

  static String req_EncKeyprod = 'C11CB813ACE571A313DBF397B8F8057E';
  static String req_Saltprod = 'C11CB813ACE571A313DBF397B8F8057E';
  static String res_DecKeyprod = '789257B2A0EFA675273732B9E07747BD';
  static String res_Saltprod = '789257B2A0EFA675273732B9E07747BD';
  // URLs
  final String paymentd;
  final String paymentDomainURL;
  final String authAPIUrl;
  final String returnUrl;

  const PaymentConfig({
    required this.login,
    required this.password,
    required this.prodId,
    required this.requestHashKey,
    required this.responseHashKey,
    required this.requestEncryptionKey,
    required this.responseDecryptionKey,
    required this.clientCode,
    required this.txnCurr,
    required this.mccCode,
    required this.merchType,
    required this.mode,
    this.custAcc = '',
    this.udf1 = '',
    this.udf2 = '',
    this.udf3 = '',
    this.udf4 = '',
    this.udf5 = '',
    required this.paymentd,
    required this.paymentDomainURL,
    required this.authAPIUrl,
    required this.returnUrl,
  });
}

PaymentConfig paymentconfigModel = isDebugmode ? uatModel : aiPayprodModel;
const PaymentConfig uatModel = PaymentConfig(
    login: "317159",
    password: 'Test@123',
    prodId: 'NSE',
    requestHashKey: 'KEY123657234',
    responseHashKey: 'KEYRESP123657234',
    requestEncryptionKey: 'A4476C2062FFA58980DC8F79EB6A799E',
    responseDecryptionKey: '75AEF0FA1B94B3C10D4F5B268F757F11',
    clientCode: "NAVIN",
    txnCurr: "INR",
    mccCode: "5499",
    merchType: "R",
    mode: "uat",
    custAcc: '639827',
    udf1: "udf1",
    udf2: "udf2",
    udf3: "udf3",
    udf4: "udf4",
    udf5: "udf5",
    paymentd: "https://caller.atomtech.in/ots/aipay/auth",
    paymentDomainURL: "https://paynetzuat.atomtech.in/ots/aipay/auth",
    authAPIUrl: "https://payment1.atomtech.in/ots/aipay/auth",
    returnUrl: "https://pgtest.atomtech.in/mobilesdk/param");

const PaymentConfig aiPayprodModel = PaymentConfig(
    login: "684703",
    password: '0e464700',
    prodId: 'ILP',
    requestHashKey: '750fa5f3c01f9a4b3e',
    responseHashKey: 'd5110c2964f4ae7bbd',
    requestEncryptionKey: 'C11CB813ACE571A313DBF397B8F8057E',
    responseDecryptionKey: '789257B2A0EFA675273732B9E07747BD',
    clientCode: "01950075",
    txnCurr: "INR",
    mccCode: "9399",
    merchType: "R",
    mode: "live",
    udf1: "udf1",
    udf2: "udf2",
    udf3: "udf3",
    udf4: "udf4",
    udf5: "udf5",
    paymentd: "https://caller.atomtech.in/ots/aipay/auth",
    paymentDomainURL: "https://payment1.atomtech.in/ots/aipay/auth",
    authAPIUrl: "https://payment1.atomtech.in/ots/aipay/auth",
    returnUrl: "https://payment.atomtech.in/mobilesdk/param");
