import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
import 'package:qr_mobile_vision_example/core/util/shared_preferences.dart';

import '../../../../caching_service/abstraction.dart';
import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/widgets/spinner_widget.dart';

import '../../data/response/buses_response.dart';

part 'all_buses_state.dart';

class AllBusesCubit extends MCubit<AllBusesInitial> {
  AllBusesCubit() : super(AllBusesInitial.initial());

  Future<void> getBuses() async {
    getDataAbstract(
      fromJson: BusResult.fromJson,
      state: state,
      getDataApi: _getBusesApi,
    );
  }

  Future<Pair<BusResult?, String?>> _getBusesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.buses,
      query: {
        'InstitutionId': AppSharedPreference.getInstitutionId,
      },
    );

    if (response.statusCode == 200) {
      return Pair(BusesResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
