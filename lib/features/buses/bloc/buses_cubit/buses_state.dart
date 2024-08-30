part of 'buses_cubit.dart';

class BusesInitial extends AbstractState<List<Buse>> {


  const BusesInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory BusesInitial.initial() {
    return const BusesInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> getSpinnerItems({int? selected}) {
    return result.map(
          (e) => SpinnerItem(
        isSelected: e.id == selected,
        id: e.id,
        name: e.driverName,
        item: e,
      ),
    ).toList();
  }
  BusesInitial copyWith({
    CubitStatuses? statuses,
    List<Buse>? result,
    String? error,
    dynamic request,
  }) {
    return BusesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
