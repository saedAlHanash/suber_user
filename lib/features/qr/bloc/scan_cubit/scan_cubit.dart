import 'package:bloc/bloc.dart';

import '../../data/response/scan_code_model.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanInitial> {
  ScanCubit() : super(ScanInitial());


}
