enum StatusIndicator {
  initial,
  loading,
  success,
  failure,
}

extension StatusIndicatorX on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isNotSuccessful => this != StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}
