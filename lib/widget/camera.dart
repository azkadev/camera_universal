import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:camera_universal/src/camera.dart" as camera;
import 'package:universal_io/io.dart';
import 'package:camera/camera.dart' as camera_package;

class Camera extends StatefulWidget {
  final camera.CameraController cameraController;
  final Widget Function(BuildContext context) onCameraNotInit;
  final Widget Function(BuildContext context) onCameraNotSelect;
  final Widget Function(BuildContext context) onCameraNotActive;
  
  final Widget Function(BuildContext context) onPlatformNotSupported;
  const Camera({
    super.key,
    required this.cameraController,
    required this.onCameraNotInit,
    required this.onCameraNotSelect,
    required this.onCameraNotActive,
    required this.onPlatformNotSupported,
  });

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    if (!widget.cameraController.is_camera_init || !widget.cameraController.is_select_camera || !widget.cameraController.is_camera_active) {
      if (!widget.cameraController.is_camera_init) {
        return widget.onCameraNotInit(context);
      }
      if (!widget.cameraController.is_select_camera) {
        return widget.onCameraNotSelect(context);
      }
      if (!widget.cameraController.is_camera_active) {
        return widget.onCameraNotActive(context);
      }
      return const CircularProgressIndicator();
    }
    if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
      return Visibility(
        visible: widget.cameraController.camera_mobile_controller.value.isInitialized,
        replacement: const CircularProgressIndicator(),
        child: camera_package.CameraPreview(
          widget.cameraController.camera_mobile_controller,
        ),
      );
    }
    return widget.onPlatformNotSupported(context);
  }
}
