import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:vote_your_face/presentation/camera/cubit/camera_cubit.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraCubit, CameraState>(
      listener: (context, state) {
        if (state.status.isCaptureSuccessful) {
          context.router.pop(state.capturedPath);
        } else if (state.status.isCaptureFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('capture failure.')),
            );
        }
      },
      builder: (context, state) {
        if (state.status.isCameraFailure) {
          return const Center(child: Text('Camera failure'));
        }
        if (state.status.isCameraReady) {
          return Scaffold(
              appBar: AppBar(title: const Text('Camera')),
              body: CameraPreview(
                BlocProvider.of<CameraCubit>(context).getController(),
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.camera_alt),
                onPressed: () =>
                    BlocProvider.of<CameraCubit>(context).cameraCaptured(),
              ));
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
