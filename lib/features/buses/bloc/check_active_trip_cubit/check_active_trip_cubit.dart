import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:qr_mobile_vision_example/core/api_manager/api_url.dart';
import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
import 'package:qr_mobile_vision_example/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../data/response/buses_response.dart';

part 'check_active_trip_state.dart';

class CheckTripCubit extends Cubit<CheckTripInitial> {
  CheckTripCubit() : super(CheckTripInitial.initial());

  Future<void> checkTrip(BuildContext context, {required SpinnerItem item}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading,request: item));
    final pair = await _checkTrip(busId: item.id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<CheckTripResult?, String?>> _checkTrip({required int busId}) async {
    final response = await APIService().postApi(
      url: PostUrl.checkActiveTrip,
      query: {'busId': busId},
    );

    if (response.statusCode == 200) {
      return Pair(CheckTripResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
