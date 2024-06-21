import 'package:equatable/equatable.dart';

abstract class VyfBaseState extends Equatable {
  const VyfBaseState();

  /// Copy the current state with given value
  VyfBaseState copyWith();

  /// Resets the state to its initial value.
  /// Implementation => return constructor of state
  VyfBaseState reset();
}
