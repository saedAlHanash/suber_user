part of 'scan_cubit.dart';

class ScanInitial {
  final ScanModel result;

  const ScanInitial({
    required this.result,
  });

  factory ScanInitial.initial() {
    return ScanInitial(
      result: ScanModel.fromJson({}),
    );
  }

  ScanInitial copyWith({
    ScanModel? result,
  }) {
    return ScanInitial(
      result: result ?? this.result,
    );
  }
}
