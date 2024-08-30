import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
import 'package:qr_mobile_vision_example/core/util/shared_preferences.dart';
import 'package:qr_mobile_vision_example/core/widgets/spinner_widget.dart';

import '../../../../caching_service/abstraction.dart';
import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/buses_response.dart';

part 'buses_state.dart';

class BusesCubit extends MCubit<BusesInitial> {
  BusesCubit() : super(BusesInitial.initial());

  @override
  String get nameCache => 'buses';

  @override
  int get timeInterval => 600;

  @override
  String get filter => state.request?.toString() ?? '';

  Future<void> getBuses({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Buse.fromJson,
      state: state,
      getDataApi: _getBuses,
      newData: newData,
    );
  }

  Future<Pair<List<Buse>?, String?>> _getBuses() async {
    final response = await APIService().getApi(
        url: GetUrl.buses,
        query: {'InstitutionId': AppSharedPreference.getInstitutionId});

    if (response.statusCode == 200) {
      return Pair(BusesResponse.fromJson(response.jsonBody).result.items, null);
    } else {
      return Pair(null, 'error');
    }
  }

  Future<void> addBuse(Buse item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Buse.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteBuseFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Buse.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
