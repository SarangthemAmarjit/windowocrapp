class VisitorEntry {
  String? idProof;
  String? idNo;
  String? category;
  String? purposeVisit;
  String? placeOfStay;
  String? visitDate;
  String? applcntName;
  String? applcntParent;
  String? applcntGender;
  DateTime? applcntDOB;
  String? applcntEmail;
  String? applcntMobile;
  String? applcntAddress;
  String? applcntState;
  String? applcntPoliceStation;
  String? applcntDistrict;
  String? applcntVillage;
  String? applcntHNo;
  String? applcntTehsil;
  String? gateID;
  String? entryType;
  String? applyDistrictID;
  String? residingPeriod;
  String? landmark;
  String? district;
  String? pinCode;
  String? amount;
  String? transactionId;
  String? lrName;
  String? lrPhone;
  String? deviceId;
  String? nearestPS;

  VisitorEntry(
      {this.idProof,
      this.idNo,
      this.category,
      this.purposeVisit,
      this.placeOfStay,
      this.visitDate,
      this.applcntName,
      this.applcntParent,
      this.applcntGender,
      this.applcntDOB,
      this.applcntEmail,
      this.applcntMobile,
      this.applcntAddress,
      this.applcntState,
      this.applcntPoliceStation,
      this.applcntDistrict,
      this.applcntVillage,
      this.applcntHNo,
      this.applcntTehsil,
      this.gateID,
      this.entryType,
      this.applyDistrictID,
      this.residingPeriod,
      this.landmark,
      this.district,
      this.pinCode,
      this.amount,
      this.transactionId,
      this.lrName,
      this.lrPhone,
      this.nearestPS,
      this.deviceId});

  factory VisitorEntry.fromJson(Map<String, dynamic> json) {
    return VisitorEntry(
        idProof: json['ID_Proof'] as String?,
        idNo: json['ID_No'] as String?,
        category: json['Category'] as String?,
        purposeVisit: json['Purpose_Visit'] as String?,
        placeOfStay: json['PlaceOfStay'] as String?,
        visitDate: json['VisitDate'] as String?,
        applcntName: json['Applcnt_Name'] as String?,
        applcntParent: json['Applcnt_Parent'] as String?,
        applcntGender: json['Applcnt_Gender'] as String?,
        applcntDOB: json['Applcnt_DOB'] != null ? DateTime.parse(json['Applcnt_DOB']) : null,
        applcntEmail: json['Applcnt_Email'] as String?,
        applcntMobile: json['Applcnt_Mobile'] as String?,
        applcntAddress: json['Applcnt_Address'] as String?,
        applcntState: json['Applcnt_State'] as String?,
        applcntPoliceStation: json['Applcnt_PoliceStation'] as String?,
        applcntDistrict: json['Applcnt_District'] as String?,
        applcntVillage: json['Applcnt_Village'] as String?,
        applcntHNo: json['Applcnt_HNo'] as String?,
        applcntTehsil: json['Applcnt_Tehsil'] as String?,
        gateID: json['Gate_ID'] as String?,
        entryType: json['EntryType'] as String?,
        applyDistrictID: json['Apply_District_ID'] as String?,
        residingPeriod: json['ResidingPeriod'] as String?,
        landmark: json['Landmark'] as String?,
        district: json['District'] as String?,
        pinCode: json['PinCode'] as String?,
        amount: json['Amount'] as String?,
        transactionId: json['TransactionId'] as String?,
        lrName: json['LRName'] as String?,
        lrPhone: json['LRPhone'] as String?,
        nearestPS: json['NearestPS'] as String?,
        deviceId: json['DeviceId']);
  }

  Map<String, String> toJson() {
    return {
      'ID_Proof': idProof ?? "NA",
      'ID_No': idNo ?? "NA",
      'Category': category ?? "NA",
      'Purpose_Visit': purposeVisit ?? "NA",
      'PlaceOfStay': placeOfStay ?? "NA",
      'VisitDate': visitDate ?? "NA",
      'Applcnt_Name': applcntName ?? "NA",
      'Applcnt_Parent': applcntParent ?? "NA",
      'Applcnt_Gender': applcntGender ?? "NA",
      'Applcnt_DOB': applcntDOB != null ? applcntDOB!.toIso8601String() : 'NA',
      'Applcnt_Email': applcntEmail ?? "NA",
      'Applcnt_Mobile': applcntMobile ?? "NA",
      'Applcnt_Address': applcntAddress ?? "NA",
      'Applcnt_State': applcntState ?? "NA",
      'Applcnt_PoliceStation': applcntPoliceStation ?? "NA",
      'Applcnt_District': applcntDistrict ?? "NA",
      'Applcnt_Village': applcntVillage ?? "NA",
      'Applcnt_HNo': applcntHNo ?? "NA",
      'Applcnt_Tehsil': applcntTehsil ?? "NA",
      'Gate_ID': gateID ?? "NA",
      'EntryType': entryType ?? "NA",
      'Apply_District_ID': applyDistrictID ?? "NA",
      'ResidingPeriod': residingPeriod ?? "NA",
      'Landmark': landmark ?? "NA",
      'District': district ?? "NA",
      'PinCode': pinCode ?? "NA",
      'Amount': amount ?? "NA",
      'TransactionId': transactionId ?? "NA",
      'LRName': lrName ?? "NA",
      'LRPhone': lrPhone ?? "NA",
      'NearestPS': nearestPS ?? "NA",
      'DeviceId': deviceId ?? "0"
    };
  }

  Map<String, String> toJsonupdate() {
    return {
      'ID_Proof': idProof ?? "NA",
      'ID_No': idNo ?? "NA",
      'Category': category ?? "NA",
      'Purpose_Visit': purposeVisit ?? "NA",
      'PlaceOfStay': placeOfStay ?? "NA",
      'VisitDate': visitDate ?? "NA",
      'Applcnt_Name': applcntName ?? "NA",
      'Applcnt_Parent': applcntParent ?? "NA",
      'Applcnt_Gender': applcntGender ?? "NA",
      'Applcnt_DOB': applcntDOB != null ? applcntDOB!.toIso8601String() : 'NA',
      'Applcnt_Email': applcntEmail ?? "NA",
      'Applcnt_Mobile': applcntMobile ?? "NA",
      'Applcnt_Address': applcntAddress ?? "NA",
      'Applcnt_State': applcntState ?? "NA",
      'Applcnt_PoliceStation': applcntPoliceStation ?? "NA",
      'Applcnt_District': applcntDistrict ?? "NA",
      'Applcnt_Village': applcntVillage ?? "NA",
      'Applcnt_HNo': applcntHNo ?? "NA",
      'Applcnt_Tehsil': applcntTehsil ?? "NA",
      'Gate_ID': gateID ?? "NA",
      'EntryType': entryType ?? "NA",
      'Apply_District_ID': applyDistrictID ?? "NA",
      'ResidingPeriod': residingPeriod ?? "NA",
      'Landmark': landmark ?? "NA",
      'District': district ?? "NA",
      'PinCode': pinCode ?? "NA",
      'Amount': amount ?? "NA",
      'TransactionId': transactionId ?? "NA",
      'LRName': lrName ?? "NA",
      'LRPhone': lrPhone ?? "NA",
      'NearestPS': nearestPS ?? "NA",
      'DeviceId': deviceId ?? '0'
    };
  }
}
