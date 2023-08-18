
import '../../../../core/strings/fix_url.dart';

class Home1Response {
  Home1Response({
    required this.result,
  });

  final Home1Result result;

  factory Home1Response.fromJson(Map<String, dynamic> json) {
    return Home1Response(
      result: Home1Result.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class Home1Result {
  Home1Result({
    required this.name,
    required this.government,
    required this.type,
    required this.imageUrl,
    required this.atharKey,
    required this.isActive,
    required this.id,
  });

  final String name;
  final num government;
  final num type;
  final String imageUrl;
  final String atharKey;
  final bool isActive;
  final int id;

  factory Home1Result.fromJson(Map<String, dynamic> json) {
    return Home1Result(
      name: json["name"] ?? "",
      government: json["government"] ?? 0,
      type: json["type"] ?? 0,
      imageUrl: FixUrl.fixAvatarImage(json["imageUrl"]),
      atharKey: json["atharKey"] ?? "",
      isActive: json["isActive"] ?? false,
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "government": government,
        "type": type,
        "imageUrl": imageUrl,
        "atharKey": atharKey,
        "isActive": isActive,
        "id": id,
      };
}
