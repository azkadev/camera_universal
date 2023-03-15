// export "package:camera/camera.dart";

// ignore_for_file: non_constant_identifier_names

// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:camera/camera.dart' as camera_package;
import 'package:camera_windows/camera_windows.dart' as camera_package_windows;

class CameraController {
  late List<camera_package.CameraDescription> camera_mobile_datas;
  late camera_package.CameraController camera_mobile_controller;
  late camera_package_windows.CameraWindows camera_windows;
  int camera_id = 0;

  bool is_camera_init = false;
  bool is_select_camera = false;
  bool is_camera_active = false;

  CameraController();

  bool get isDesktop => Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  bool get isMobile => Platform.isAndroid || Platform.isIOS || kIsWeb;

  Future<void> initializeCameras() async {
    if (isMobile) {
      camera_mobile_datas = await camera_package.availableCameras();
      is_camera_init = true;
    }
    if (isDesktop) {
      if (Platform.isWindows) {
        camera_windows = camera_package_windows.CameraWindows();
        camera_mobile_datas = await camera_windows.availableCameras();
        is_camera_init = true;
      }
    }
    return;
  }

  Future<void> initializeCamera({
    required void Function(void Function() callback) setState,
  }) async {
    if (!is_camera_init) {
      return;
    }
    if (isMobile) {
      camera_mobile_controller = camera_package.CameraController(
        camera_mobile_datas.first,
        camera_package.ResolutionPreset.max,
      );
      is_select_camera = true;
    }

    if (isDesktop) {
      if (Platform.isWindows) {
        camera_id = await camera_windows.createCamera(camera_mobile_datas.first, camera_package.ResolutionPreset.max);
        is_select_camera = true;
        setState(() {});
      }
    }
    return;
  }

  Future<void> initializeCameraById({
    required int camera_id,
    required void Function(void Function() callback) setState,
    required bool Function() mounted,
  }) async {
    if (!is_camera_init) {
      return;
    }
    if (isMobile) {
      for (var i = 0; i < camera_mobile_datas.length; i++) {
        camera_package.CameraDescription camera_mobile_data = camera_mobile_datas[i];
        if (i == (camera_id - 1)) {
          camera_mobile_controller = camera_package.CameraController(
            camera_mobile_data,
            camera_package.ResolutionPreset.max,
          );
          is_select_camera = true;
          await activateCamera(setState: setState, mounted: mounted);
          return;
        }
      }
    }
    if (isDesktop) {
      if (Platform.isWindows) {
        for (var i = 0; i < camera_mobile_datas.length; i++) {
          camera_package.CameraDescription camera_mobile_data = camera_mobile_datas[i];
          if (i == (camera_id - 1)) {
            camera_id = await camera_windows.createCamera(
              camera_mobile_data,
              camera_package.ResolutionPreset.max,
            );
            is_select_camera = true;
            await activateCamera(setState: setState, mounted: mounted);
            return;
          }
        }
      }
    }
    return;
  }

  Future<void> activateCamera({
    required void Function(void Function() callback) setState,
    required bool Function() mounted,
  }) async {
    if (!is_camera_init) {
      return;
    }
    if (!is_select_camera) {
      return;
    }
    if (isMobile) {
      try {
        await camera_mobile_controller.initialize();
        if (!mounted.call()) {
          return;
        }
        is_camera_active = true;

        setState(() {});
      } catch (e) {
        print(e);
      }
    }
    if (isDesktop) {
      await camera_windows.initializeCamera(camera_id);
      is_camera_active = true;
      setState(() {});
    }
  }

  Future<void> dispose() async {
    if (!is_camera_init) {
      return;
    }
    if (!is_select_camera) {
      return;
    }
    if (!is_camera_active) {
      return;
    }
    if (isMobile) {
      await camera_mobile_controller.dispose();
    }
    if (isDesktop) {
      if (Platform.isWindows) {
        await camera_windows.dispose(camera_id);
      }
    }
  }
}
