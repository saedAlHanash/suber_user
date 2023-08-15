import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:qr_mobile_vision_example/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'delete_super_user_state.dart';

class DeleteSuperUserCubit extends Cubit<DeleteSuperUserInitial> {
  DeleteSuperUserCubit() : super(DeleteSuperUserInitial.initial());

  Future<void> deleteSuperUsers(BuildContext context, {required int id}) async {
    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _deleteSuperUsersApi(id: id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _deleteSuperUsersApi({required int id}) async {
    final response = await APIService()
        .deleteApi(url: DeleteUrl.deleteSuperUsers, query: {'Id': id});

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
