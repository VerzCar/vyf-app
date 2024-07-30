import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/camera/cubit/camera_cubit.dart';
import 'package:vote_your_face/presentation/camera/view/view.dart';

@RoutePage()
class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CameraCubit>(
      create: (BuildContext context) => CameraCubit()..cameraInitialized(),
      child: const CameraView(),
    );
  }
}
