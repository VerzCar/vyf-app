import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:vote_your_face/presentation/camera/cubit/camera_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: SafeArea(
        child: BlocListener<CameraCubit, CameraState>(
          listenWhen: (prev, current) => prev.status != current.status,
          listener: (context, state) {
            if (state.status.isCaptureSuccessful) {
              context.router.pop(state.capturedPath);
            } else if (state.status.isCaptureFailure) {
              EventTrigger.error(
                context: context,
                msg: 'Camera capture failure. Try again.',
              );
            }
          },
          child: BlocBuilder<CameraCubit, CameraState>(
            builder: (context, state) {
              switch (state.status) {
                case CameraStateStatus.ready:
                  return CameraPreview(
                    BlocProvider.of<CameraCubit>(context).getController(),
                  );
                case CameraStateStatus.failureCamera:
                  return const Center(child: Text('Error'));
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () => BlocProvider.of<CameraCubit>(context).cameraCaptured(),
      ),
    );
  }
}
