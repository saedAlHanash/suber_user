import 'package:bloc/bloc.dart';

import '../../data/response/scan_code_model.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanInitial> {
  ScanCubit() : super(ScanInitial.initial());

  void initCode({required ScanModel? model}) {
    emit(state.copyWith(result: model));
    Future.delayed(
      Duration(seconds: 3),
      () {
        emit(ScanInitial.initial());
      },
    );
  }
}
