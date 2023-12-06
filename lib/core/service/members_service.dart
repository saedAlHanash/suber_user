import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:qr_mobile_vision_example/main.dart';

import '../../features/super_user/data/response/member_response.dart';
import '../util/shared_preferences.dart';

class UsersService {
  Future<void> addMembers(List<Member> users) async {
    for (var i = 0; i < users.length; i++) {
      await memberBox.put(users[i].id, jsonEncode(users[i]));
    }
  }

  Member? getMemberById(int id) {
    final memberJson = memberBox.get(id);
    if (memberJson == null) return null;
    return Member.fromJson(jsonDecode(memberJson));
  }
}
