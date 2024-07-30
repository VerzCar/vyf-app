import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/camera/cubit/camera_utils.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState());

  final CameraUtils _cameraUtils = CameraUtils();
  final ResolutionPreset _resolutionPreset = ResolutionPreset.high;
  final CameraLensDirection _cameraLensDirection = CameraLensDirection.back;

  late CameraController _controller;

  CameraController getController() => _controller;

  bool isInitialized() => _controller.value.isInitialized;

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }

  void cameraInitialized() async {
    try {
      _controller = await _cameraUtils.cameraController(
        _resolutionPreset,
        _cameraLensDirection,
      );

      await _controller.initialize();

      emit(state.copyWith(
        status: CameraStateStatus.ready,
      ));
    } catch (e) {
      _controller.dispose();
      sl<Logger>().t(
        'cameraInitialized',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: CameraStateStatus.failureCamera,
      ));
    }
  }

  void cameraCaptured() async {
    try {
      if (!state.status.isCameraReady) {
        return;
      }

      emit(state.copyWith(
        status: CameraStateStatus.loadingCapture,
      ));

      final path = await _cameraUtils.path();

      await _controller.takePicture();

      emit(state.copyWith(
        status: CameraStateStatus.successCapture,
        capturedPath: path,
      ));
    } catch (e) {
      sl<Logger>().t(
        'cameraCaptured',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: CameraStateStatus.failureCapture,
      ));
    }
  }

  void cameraStopped() {
    try {
      _controller.dispose();
      emit(state.copyWith(
        status: CameraStateStatus.initial,
      ));
    } catch (e) {
      sl<Logger>().t(
        'cameraStopped',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: CameraStateStatus.failureCamera,
      ));
    }
  }
}
