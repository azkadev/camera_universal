import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera_universal/camera_universal.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      home: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  CameraController cameraController = CameraController();
  String error_msg = "";
  @override
  void initState() {
    super.initState();
    task();
  }

  Future<void> task() async {
    try {
      await cameraController.initializeCameras();
      await cameraController.initializeCamera(
        setState: setState,
      );

      await cameraController.activateCamera(
        setState: setState,
        mounted: () {
          return mounted;
        },
      );
    } catch (e,stack) {
      print(e);
      print(stack);
      setState(() {
        error_msg = "error";
      });
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: error_msg.isEmpty,
        replacement: Text(error_msg),
        child: Camera(
          cameraController: cameraController,
          onCameraNotInit: (context) {
            return Text("Camera not init");
            return const SizedBox.shrink();
          },
          onCameraNotSelect: (context) {
            return Text("Camera not select");
            return const SizedBox.shrink();
          },
          onCameraNotActive: (context) {
            return Text("Camera not active");
            return const SizedBox.shrink();
          },
          onPlatformNotSupported: (context) {
            return Text("Camera not supported");
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(
            cameraController.action_change_camera(
              camera_id: 1,
              setState: setState,
              mounted: () {
                return mounted;
              },
              onCameraNotInit: () {},
              onCameraNotSelect: () {},
              onCameraNotActive: () {},
            ),
          );
        },
        child: const Icon(
          Icons.add_circle_outline_sharp,
        ),
      ),
    );
  }
}
