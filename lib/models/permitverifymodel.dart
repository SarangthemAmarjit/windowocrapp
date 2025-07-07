import '../cons/utils.dart';

class PermitApplication {
  final int id;
  final String applicationNo;
  final String name;
  final String parentName;
  final String idProof;
  final String idNo;
  final String gender;
  final DateTime? dob;
  final String idMark;
  final String occupation;
  final String photo;
  final String signature;
  final String idCard;
  final String address;
  final String mobile;
  final String email;
  final String state;
  final String policeStation;
  final String district;
  final String houseNo;
  final String tehsil;
  final String village;
  final DateTime? applicationDate;
  final String entryBy;
  final String entryType;
  final bool statusExit;

  PermitApplication({
    required this.id,
    required this.applicationNo,
    required this.name,
    required this.parentName,
    required this.idProof,
    required this.idNo,
    required this.gender,
    required this.dob,
    required this.idMark,
    required this.occupation,
    required this.photo,
    required this.signature,
    required this.idCard,
    required this.state,
    required this.policeStation,
    required this.district,
    required this.houseNo,
    required this.tehsil,
    required this.address,
    required this.mobile,
    required this.email,
    required this.village,
    this.applicationDate,
    required this.entryBy,
    required this.entryType,
    required this.statusExit,
  });

  factory PermitApplication.fromJson(Map<String, dynamic> json) {
    return PermitApplication(
      id: json['id'],
      applicationNo: json['applicationNo'],
      name: json['name'],
      parentName: json['parentName'],
      idProof: json['idProof'],
      idNo: json['idNo'],
      gender: json['gender'],
      dob: json['dob'] != null ? parseAnyDate(json['dob']) : null,
      idMark: json['idMark'] ?? '',
      occupation: json['occupation'] ?? '',
      photo: json['photo'],
      signature: json['signature'],
      idCard: json['idCard'],
      state: json['state'],
      policeStation: json['policeStation'],
      district: json['district'],
      houseNo: json['houseNo'] ?? '',
      tehsil: json['tehsil'],
      address: json['address'],
      mobile: json['mobile'],
      email: json['email'],
      village: json['village'],
      applicationDate:
          json['applicationDate'] != null ? parseAnyDate(json['applicationDate']) : null,
      entryBy: json['entryBy'],
      entryType: json['entryType'],
      statusExit: json['statusExit'].toString().toLowerCase() == 'false' ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'applicationNo': applicationNo,
      'name': name,
      'parentName': parentName,
      'idProof': idProof,
      'idNo': idNo,
      'gender': gender,
      'dob': dob,
      'idMark': idMark,
      'occupation': occupation,
      'photo': photo,
      'signature': signature,
      'idCard': idCard,
      'state': state,
      'policeStation': policeStation,
      'district': district,
      'houseNo': houseNo,
      'tehsil': tehsil,
      'village': village,
      'applicationDate': applicationDate,
      'entryBy': entryBy,
      'entryType': entryType,
      'statusExit': statusExit,
    };
  }
}
