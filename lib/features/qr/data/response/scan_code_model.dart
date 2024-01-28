import 'dart:convert';

import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
import 'package:qr_mobile_vision_example/core/util/shared_preferences.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/service/members_service.dart';

class ScanModel {
  ScanModel({
    required this.id,
    required this.institutionId,
    required this.name,
    required this.image,
    required this.state,
    required this.expire,
  });

  final int id;
  final num institutionId;
  final String name;
  final String image;
  bool state;
  final DateTime? expire;

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      id: json["id"] ?? 0,
      institutionId: json["institutionId"] ?? 0,
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      state: json["state"] ?? true,
      expire: DateTime.tryParse(json["expire"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "institutionId": institutionId,
        "name": name,
        "image": image,
        "state": state,
        "expire": expire?.toIso8601String(),
      };
}

ScanModel? convertFromString(String? code) {
  if (code == null) return null;
  final id = int.tryParse(code) ?? 0;
  if (id == 0) return null;

  try {
    final member = sl<UsersService>().getMemberById(id);

    if (member == null) return ScanModel.fromJson({});

    if (member.institutionId != AppSharedPreference.getInstitutionId) return null;

    var model = ScanModel(
      id: member.id,
      institutionId: member.institutionId,
      name: member.fullName,
      image: member.imageUrl,
      state: member.memberStateBool,
      expire:
          member.subscriptions.isEmpty ? null : member.subscriptions.last.expirationDate,
    );

    return model;
  } catch (e) {
    return null;
  }
}
