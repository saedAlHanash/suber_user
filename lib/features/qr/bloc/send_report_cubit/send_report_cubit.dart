import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:qr_mobile_vision_example/core/api_manager/api_url.dart';
import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
import 'package:qr_mobile_vision_example/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/service/report_request_service.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/report_request.dart';
import '../../data/response/scan_code_model.dart';

part 'send_report_state.dart';

class SendReportCubit extends Cubit<SendReportInitial> {
  SendReportCubit() : super(SendReportInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> sendReport(BuildContext context, {required ReportRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _sendReportApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }
  void initial ()
  {
    emit(SendReportInitial.initial());
  }  Future<Pair<ScanResult?, String?>> _sendReportApi(
      {required ReportRequest request}) async {
    if (await network.isConnected) {
      final response = await APIService().postApi(
        url: PostUrl.postSingleReport,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(ScanResponse.fromJson(response.jsonBody).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
