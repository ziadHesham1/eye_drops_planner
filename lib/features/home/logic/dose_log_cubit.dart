import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'dose_log_state.dart';

class DoseLogCubit extends HydratedCubit<DoseLogState> {
  DoseLogCubit() : super(const DoseLogState(taken: {}));

  static String keyFor(DateTime day, int slotIndex, String drugName) {
    final d = DateTime(day.year, day.month, day.day);
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}|$slotIndex|$drugName';
  }

  bool isTaken(DateTime day, int slotIndex, String drugName) =>
      state.taken[keyFor(day, slotIndex, drugName)] == true;

  void toggleTaken(DateTime day, int slotIndex, String drugName) {
    final key = keyFor(day, slotIndex, drugName);
    final next = Map<String, bool>.from(state.taken);
    if (next[key] == true) {
      next.remove(key);
    } else {
      next[key] = true;
    }
    emit(DoseLogState(taken: next));
  }

  @override
  DoseLogState? fromJson(Map<String, dynamic> json) {
    final raw = json['taken'];
    if (raw is! Map) return const DoseLogState(taken: {});
    return DoseLogState(
      taken: raw.map((k, v) => MapEntry(k.toString(), v == true)),
    );
  }

  @override
  Map<String, dynamic>? toJson(DoseLogState state) {
    return {'taken': state.taken};
  }
}
