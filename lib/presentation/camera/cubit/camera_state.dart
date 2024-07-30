part of 'camera_cubit.dart';

enum CameraStateStatus {
  initial,
  ready,
  loadingCapture,
  successCapture,
  failureCamera,
  failureCapture,
}

extension CameraStateStatusX on CameraStateStatus {
  bool get isInitial => this == CameraStateStatus.initial;

  bool get isCameraReady => this == CameraStateStatus.ready;

  bool get icCaptureLoading => this == CameraStateStatus.loadingCapture;

  bool get isCaptureSuccessful => this == CameraStateStatus.successCapture;

  bool get isCameraFailure => this == CameraStateStatus.failureCamera;

  bool get isCaptureFailure => this == CameraStateStatus.failureCapture;
}

final class CameraState extends Equatable {
  const CameraState(
      {this.status = CameraStateStatus.initial, this.capturedPath = ''});

  final CameraStateStatus status;
  final String capturedPath;

  CameraState copyWith({
    CameraStateStatus? status,
    String? capturedPath,
  }) {
    return CameraState(
      status: status ?? this.status,
      capturedPath: capturedPath ?? this.capturedPath,
    );
  }

  @override
  List<Object> get props => [
        status,
        capturedPath,
      ];
}
