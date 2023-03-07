// import 'package:flutter/material.dart';
// import 'package:camera_universal/camera_universal.dart';
// import "package:camera/camera.dart";

// void main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Camera.init();
//   runApp(MaterialApp(
//     home: MainApp(),
//   ));
// }

// class MainApp extends StatefulWidget {
//   MainApp({
//     super.key,
//   });
//   @override
//   State<MainApp> createState() => _MainAppState();
// }

// class _MainAppState extends State<MainApp> {
//   CameraController cameraController = CameraController(
//     Camera.camera_mobile_static.first,
//     ResolutionPreset.max,
//   );
//   @override
//   void initState() {
//     super.initState();
//     task();
//   }

//   Future<void> task() async {
//     try {
//       await cameraController.initialize();
//       if (!mounted) {
//         return;
//       }
//       setState(() {

//       });
//     } catch (e) {
//       if (e is CameraException) {
//         if (e.code == "CameraAccessDenied") {}
//       }
//     }
//   }

//   @override
//   void dispose() {
//     cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(Camera.is_camera_init_static);
//     return Scaffold(
//       body: Visibility(
//         visible: cameraController.value.isInitialized,
//         replacement: CircularProgressIndicator(),
//         child: CameraPreview(
//           cameraController,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:camera_universal/camera_universal.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  MainApp({
    super.key,
  });
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  CameraController cameraController = CameraController();
  @override
  void initState() {
    super.initState();
    task();
  }

  Future<void> task() async {
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
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Camera(
        cameraController: cameraController,
        onCameraNotInit: (context) {
          
          return const SizedBox.shrink();
        },
        onCameraNotSelect: (context) {
          
          return const SizedBox.shrink();
        },
        onCameraNotActive: (context) {
          
          return const SizedBox.shrink();
        },
        onPlatformNotSupported: (context) {
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // cameraController.action_start_video_recording();
        },
        child: const Icon(
          Icons.add_circle_outline_sharp,
        ),
      ),
    );
  }
}
