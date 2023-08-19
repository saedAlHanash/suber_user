import '../../../../core/strings/fix_url.dart';

class ScanResponse {
  ScanResponse({
    required this.result,
  });

  final ScanResult result;

  factory ScanResponse.fromJson(Map<String, dynamic> json) {
    return ScanResponse(
      result: ScanResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class ScanResult {
  ScanResult({
    required this.id,
    required this.busMember,
    required this.date,
    required this.isParticipated,
    required this.isSubscribed,
    required this.isQrScaned,
  });

  final int id;
  final BusMember busMember;
  final DateTime? date;
  final bool isParticipated;
  final bool isSubscribed;
  final bool isQrScaned;

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      id: json["id"] ?? 0,
      busMember: BusMember.fromJson(json["busMember"] ?? {}),
      date: DateTime.tryParse(json["date"] ?? ""),
      isParticipated: json["isParticipated"] ?? false,
      isSubscribed: json["isSubscribed"] ?? false,
      isQrScaned: json["isQrScaned"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "busMember": busMember.toJson(),
        "date": date?.toIso8601String(),
        "isParticipated": isParticipated,
        "isSubscribed": isSubscribed,
        "isQrScaned": isQrScaned,
      };
}

class BusMember {
  BusMember({
    required this.id,
    required this.fullName,
    required this.imageUrl,
    required this.address,
    required this.late,
    required this.longe,
    required this.userName,
    required this.password,
    required this.phoneNo,
    required this.facility,
    required this.idNumber,
    required this.collegeIdNumber,
    required this.institutionId,
  });

  final int id;
  final String fullName;
  final String imageUrl;
  final String address;
  final num late;
  final num longe;
  final String userName;
  final String password;
  final String phoneNo;
  final String facility;
  final String idNumber;
  final String collegeIdNumber;
  final num institutionId;

  factory BusMember.fromJson(Map<String, dynamic> json) {
    return BusMember(
      id: json["id"] ?? 0,
      fullName: json["fullName"] ?? "",
      imageUrl: FixUrl.fixAvatarImage(json["imageUrl"] ?? ""),
      address: json["address"] ?? "",
      late: json["late"] ?? 0,
      longe: json["longe"] ?? 0,
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      phoneNo: json["phoneNo"] ?? "",
      facility: json["facility"] ?? "",
      idNumber: json["idNumber"] ?? "",
      collegeIdNumber: json["collegeIdNumber"] ?? "",
      institutionId: json["institutionId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "imageUrl": imageUrl,
        "address": address,
        "late": late,
        "longe": longe,
        "userName": userName,
        "password": password,
        "phoneNo": phoneNo,
        "facility": facility,
        "idNumber": idNumber,
        "collegeIdNumber": collegeIdNumber,
        "institutionId": institutionId,
      };
}
