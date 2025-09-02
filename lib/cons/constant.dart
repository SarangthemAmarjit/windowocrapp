import '../models/permit.dart';

List<String> genders = ["Male", "Female", "Others"];
String gate = "Imphal Airport";
String rupee = "₹";
bool onlinePayment = true;
bool isDebugmode = false;
// String printername = "CUSTOM K80";
String printername = "CUSTOM K80 (Copy 1)";
final List<String> cardTypes = ['Aadhar', 'PAN', 'Voter', 'Driving Licence'];
final List<String> purposes = ["Tourist", "Official", "Business", "Others"];
List<String> states = [
  "Andaman and Nicobar Islands",
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chandigarh",
  "Chhattisgarh",
  "Dadra and Nagar Haveli",
  "Daman and Diu",
  "Delhi",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jammu and Kashmir",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Ladakh",
  "Lakshadweep",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Pondicherry",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
  "Uttar Pradesh",
  "West Bengal"
];

final List<String> documentTypes = [
  'Driving License',
  'Passport',
  'Aadhaar Card',
  'Pan Card'
];

List<String> termcondition = [
  "a)I shall be responsible for the good conduct during my stay in the state of Manipur.",
  "b)I shall leave the State anytime, if the authorities direct",
  "c)I shall furnish my whereabouts if called upon.",
  "d)In the event of any default on my part, I shall be liable for prosecutation by competent court."
];

Map<String, dynamic> paymentmethod = {
  "DC": "Debit Card",
  "NB": "Net Banking",
  "CC": "Credit Card",
  "MW": "Wallet",
  "PP": "PhonePe",
  "PW": "Paytm Wallet",
  "EM": "EMI",
  "NR": "Challan",
  "BQ": "BharatQR",
  "UP": "Unified Payment Interface",
};

List<String> districts = [
  "Senapati",
  "Imphal East",
  "Thoubal",
  "Bishnupur",
  "Churachandpur",
  "Pherzawl",
  "Chandel",
  "Tengnoupal",
  "Ukhrul",
  "Tamenglong",
  "Noney",
  "Jiribam",
  "Imphal West",
  "Kangpokpi",
  "Kakching",
  "Kamjong",
];

final dummyVisitorEntrys = VisitorEntry()
  ..idProof = 'Aadhar Card'
  ..idNo = '123456789782'
  ..category = 'Tourist'
  ..purposeVisit = 'Sightseeing'
  ..placeOfStay = 'Hotel Blue Orchid'
  ..visitDate = '2025-04-20'
  ..applcntName = 'Priya Sharma'
  ..applcntParent = 'Ramesh Sharma'
  ..applcntGender = 'Female'
  ..applcntDOB = DateTime.now()
  ..applcntEmail = 'priya.sharma@example.com'
  ..applcntMobile = '9876543210'
  ..applcntAddress = '123 Main Street, MG Road'
  ..applcntState = 'Manipur'
  ..applcntPoliceStation = 'Imphal PS'
  ..applcntDistrict = 'Imphal East'
  ..applcntVillage = 'Thangmeiband'
  ..applcntHNo = '45'
  ..applcntTehsil = 'Imphal East'
  ..gateID = 'GT123'
  ..entryType = 'Online'
  ..applyDistrictID = 'D-101'
  ..residingPeriod = '30'
  ..landmark = 'Near Ima Market'
  ..district = 'Imphal East'
  ..pinCode = '795001'
  ..amount = '100'
  ..transactionId = 'TXN202504201234'
  ..lrName = 'Sita Devi'
  ..nearestPS = 'Imphal PS';
