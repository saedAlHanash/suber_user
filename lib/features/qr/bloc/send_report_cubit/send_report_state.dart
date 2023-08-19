part of 'send_report_cubit.dart';

class SendReportInitial {
  final CubitStatuses statuses;
  final ScanResult result;
  final String error;

  const SendReportInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory SendReportInitial.initial() {
    return  SendReportInitial(
      result: ScanResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  SendReportInitial copyWith({
    CubitStatuses? statuses,
    ScanResult? result,
    String? error,
  }) {
    return SendReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
