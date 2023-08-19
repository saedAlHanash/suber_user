part of 'check_active_trip_cubit.dart';

class CheckTripInitial {
  final CubitStatuses statuses;
  final CheckTripResult result;
  final String error;
  final Command command;
  final SpinnerItem request;

  const CheckTripInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
    required this.request,
  });

  factory CheckTripInitial.initial() {
    return CheckTripInitial(
      result: CheckTripResult.fromJson({}),
      error: '',
      command: Command.initial(),
      request: SpinnerItem(),
      statuses: CubitStatuses.init,
    );
  }



  CheckTripInitial copyWith({
    CubitStatuses? statuses,
    CheckTripResult? result,
    String? error,
    Command? command,
    SpinnerItem? request,
  }) {
    return CheckTripInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
      request: request ?? this.request,
    );
  }
}
