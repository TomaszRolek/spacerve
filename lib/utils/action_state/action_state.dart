import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_state.freezed.dart';

@freezed
class ActionState<T> with _$ActionState<T> {
  const factory ActionState.idle() = Idle;

  const factory ActionState.success([T? data]) = Success;

  const factory ActionState.loading() = Loading;

  const factory ActionState.error({required String message}) = Error;
}