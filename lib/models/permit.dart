
class VisitorEntry {
  final String? idProof;
  final String? idNo;
  final String? category;
  final String? purposeVisit;
  final String? placeOfStay;
  final String? visitDate;
  final String? applcntName;
  final String? applcntParent;
  final String? applcntGender;
  final String? applcntDOB;
  final String? applcntEmail;
  final String? applcntMobile;
  final String? applcntAddress;
  final String? applcntState;
  final String? applcntPoliceStation;
  final String? applcntDistrict;
  final String? applcntVillage;
  final String? applcntHNo;
  final String? applcntTehsil;
  final String? gateID;
  final String? entryType;
  final String? applyDistrictID;
  final String? residingPeriod;
  final String? landmark;
  final String? district;
  final String? pinCode;

  VisitorEntry({
    this.idProof,
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
  });

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
      applcntDOB: json['Applcnt_DOB'] as String?,
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
    );
  }

  Map<String,String> toJson() {
    return {
      'ID_Proof': idProof.toString(),
      'ID_No': idNo.toString(),
      'Category': category.toString(),
      'Purpose_Visit': purposeVisit.toString(),
      'PlaceOfStay': placeOfStay.toString(),
      'VisitDate': visitDate.toString(),
      'Applcnt_Name': applcntName.toString(),
      'Applcnt_Parent': applcntParent.toString(),
      'Applcnt_Gender': applcntGender.toString(),
      'Applcnt_DOB': applcntDOB.toString(),
      'Applcnt_Email': applcntEmail.toString(),
      'Applcnt_Mobile': applcntMobile.toString(),
      'Applcnt_Address': applcntAddress.toString(),
      'Applcnt_State': applcntState.toString(),
      'Applcnt_PoliceStation': applcntPoliceStation.toString(),
      'Applcnt_District': applcntDistrict.toString(),
      'Applcnt_Village': applcntVillage.toString(),
      'Applcnt_HNo': applcntHNo.toString(),
      'Applcnt_Tehsil': applcntTehsil.toString(),
      'Gate_ID': gateID.toString(),
      'EntryType': entryType.toString(),
      'Apply_District_ID': applyDistrictID.toString(),
      'ResidingPeriod': residingPeriod.toString(),
      'Landmark': landmark.toString(),
      'District': district.toString(),
      'PinCode': pinCode.toString(),
    };
  }
}
