import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/fix_url.dart';

class MembersResponse {
  MembersResponse({
    required this.result,
  });

  final List<Member> result;

  factory MembersResponse.fromJson(Map<String, dynamic> json) {
    return MembersResponse(
      result: json["result"] == null
          ? []
          : List<Member>.from(json["result"]!.map((x) => Member.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x.toJson()).toList(),
      };
}

class Subscription {
  Subscription({
    required this.institutionId,
    required this.institution,
    required this.memberId,
    required this.member,
    required this.supscriptionDate,
    required this.expirationDate,
    required this.isActive,
    required this.semester,
    required this.id,
  });

  final num institutionId;
  final dynamic institution;
  final num memberId;
  final Member? member;
  final DateTime? supscriptionDate;
  final DateTime? expirationDate;
  final bool isActive;
  final dynamic semester;
  final int id;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      institutionId: json["institutionId"] ?? 0,
      institution: json["institution"],
      memberId: json["memberId"] ?? 0,
      member: json["member"] == null ? null : Member.fromJson(json["member"]),
      supscriptionDate: DateTime.tryParse(json["supscriptionDate"] ?? ""),
      expirationDate: DateTime.tryParse(json["expirationDate"] ?? ""),
      isActive: json["isActive"] ?? false,
      semester: json["semester"],
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "institutionId": institutionId,
        "institution": institution,
        "memberId": memberId,
        "member": member?.toJson(),
        "supscriptionDate": supscriptionDate?.toIso8601String(),
        "expirationDate": expirationDate?.toIso8601String(),
        "isActive": isActive,
        "semester": semester,
        "id": id,
      };
}

class Member {
  Member({
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
    required this.emergencyPhone,
    required this.session,
    required this.institutionId,
    required this.subscriptions,
    required this.tickets,
    required this.pickupPoints,
    required this.id,
  });

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
  final dynamic emergencyPhone;
  final String session;
  final num institutionId;
  final List<Subscription> subscriptions;
  final List<dynamic> tickets;
  final List<dynamic> pickupPoints;
  final int id;

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      fullName: json["fullName"] ?? "",
      imageUrl: FixUrl.fixAvatarImage(json["imageUrl"]),
      address: json["address"] ?? "",
      late: json["late"] ?? 0,
      longe: json["longe"] ?? 0,
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      phoneNo: json["phoneNo"] ?? "",
      facility: json["facility"] ?? "",
      idNumber: json["idNumber"] ?? "",
      collegeIdNumber: json["collegeIdNumber"] ?? "",
      emergencyPhone: json["emergencyPhone"],
      session: json["session"] ?? "",
      institutionId: json["institutionId"] ?? 0,
      subscriptions: json["subscriptions"] == null
          ? []
          : List<Subscription>.from(
              json["subscriptions"]!.map((x) => Subscription.fromJson(x))),
      tickets: json["tickets"] == null
          ? []
          : List<dynamic>.from(json["tickets"]!.map((x) => x)),
      pickupPoints: json["pickupPoints"] == null
          ? []
          : List<dynamic>.from(json["pickupPoints"]!.map((x) => x)),
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
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
        "emergencyPhone": emergencyPhone,
        "session": session,
        "institutionId": institutionId,
        "subscriptions": subscriptions.map((x) => x.toJson()).toList(),
        "tickets": tickets.map((x) => x).toList(),
        "pickupPoints": pickupPoints.map((x) => x).toList(),
        "id": id,
      };
}
