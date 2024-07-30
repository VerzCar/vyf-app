import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VyfCamera extends StatefulWidget {
  const VyfCamera({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<VyfCamera> createState() => _VyfCameraState();
}

class _VyfCameraState extends State<VyfCamera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
