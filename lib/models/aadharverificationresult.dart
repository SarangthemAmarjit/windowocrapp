class AadhaarVerificationResult {
  final String clientId;
  final String fullName;
  final String dob;
  final String gender;
  final AadhaarAddress address;
  final bool faceStatus;
  final double faceScore;
  final String zip;
  final String profileImage;
  final bool hasImage;
  final String emailHash;
  final String mobileHash;
  final String rawXml;
  final String zipData;
  final String careOf;
  final String shareCode;
  final bool mobileVerified;
  final String referenceId;
  final String aadhaarPdf;
  final String status;
  final String uniquenessId;

  AadhaarVerificationResult({
    required this.clientId,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.address,
    required this.faceStatus,
    required this.faceScore,
    required this.zip,
    required this.profileImage,
    required this.hasImage,
    required this.emailHash,
    required this.mobileHash,
    required this.rawXml,
    required this.zipData,
    required this.careOf,
    required this.shareCode,
    required this.mobileVerified,
    required this.referenceId,
    required this.aadhaarPdf,
    required this.status,
    required this.uniquenessId,
  });

  factory AadhaarVerificationResult.fromJson(Map<String, dynamic> json) {
    return AadhaarVerificationResult(
      clientId: json['client_id'],
      fullName: json['full_name'],
      dob: json['dob'],
      gender: json['gender'],
      address: AadhaarAddress.fromJson(json['address']),
      faceStatus: json['face_status'],
      faceScore: (json['face_score'] as num).toDouble(),
      zip: json['zip'],
      profileImage: json['profile_image'],
      hasImage: json['has_image'],
      emailHash: json['email_hash'],
      mobileHash: json['mobile_hash'],
      rawXml: json['raw_xml'],
      zipData: json['zip_data'],
      careOf: json['care_of'],
      shareCode: json['share_code'],
      mobileVerified: json['mobile_verified'],
      referenceId: json['reference_id'],
      aadhaarPdf: json['aadhaar_pdf'],
      status: json['status'],
      uniquenessId: json['uniqueness_id'],
    );
  }
}

class AadhaarAddress {
  final String country;
  final String dist;
  final String state;
  final String po;
  final String loc;
  final String vtc;
  final String subdist;
  final String street;
  final String house;
  final String landmark;

  AadhaarAddress({
    required this.country,
    required this.dist,
    required this.state,
    required this.po,
    required this.loc,
    required this.vtc,
    required this.subdist,
    required this.street,
    required this.house,
    required this.landmark,
  });

  factory AadhaarAddress.fromJson(Map<String, dynamic> json) {
    return AadhaarAddress(
      country: json['country'],
      dist: json['dist'],
      state: json['state'],
      po: json['po'],
      loc: json['loc'],
      vtc: json['vtc'],
      subdist: json['subdist'],
      street: json['street'],
      house: json['house'],
      landmark: json['landmark'],
    );
  }
}
