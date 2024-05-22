// ignore_for_file: non_constant_identifier_names, unused_local_variable

import "package:flutter/widgets.dart";
import "package:universal_io/io.dart";

import "camera_controller.dart";
export "camera_controller.dart";

extension CameraControllerExtensions on CameraController {
  Widget widget_build_preview({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) {
    if (!is_camera_init) {
      onCameraNotInit();
      return const SizedBox.shrink();
    }
    if (!is_select_camera) {
      onCameraNotSelect();
      return const SizedBox.shrink();
    }
    if (!is_camera_active) {
      onCameraNotActive();
      return const SizedBox.shrink();
    }
    if (isMobile) {
      return camera_mobile_controller.buildPreview();
    } else if (isDesktop) {
      if (Platform.isWindows) {
        return camera_windows.buildPreview(camera_id);
      }
    }
    return const SizedBox.shrink();
  }

  bool util_check_camera({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) {
    if (!is_camera_init) {
      onCameraNotInit();
      return false;
    }
    if (!is_select_camera) {
      onCameraNotSelect();
      return false;
    }
    if (!is_camera_active) {
      onCameraNotActive();
      return false;
    }
    return true;
  }

  Future<void> action_template({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) async {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return;
    }
    if (isMobile) {
      var res = (await camera_mobile_controller.startVideoRecording());
    }
    return;
  }

  Future<void> action_change_camera({
    required int cameraId,
    required void Function(void Function() callback) setState,
    required bool Function() mounted,
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) async {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return;
    }
      camera_id = cameraId;
    if (isMobile) {
      await initializeCameraById(
        camera_id: camera_id,
        setState: setState,
        mounted: mounted,
      );
    } else if (isDesktop) {
      if (Platform.isWindows) {
        await dispose();

        await initializeCameraById(
          camera_id: camera_id,
          setState: setState,
          mounted: mounted,
        );
      }
    }
    return;
  }

  action_start_video_recording({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) async {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return;
    }
    if (isMobile) {
      var res = (await camera_mobile_controller.startVideoRecording());
    } else if (isDesktop) {
      if (Platform.isWindows) {
        await camera_windows.startVideoRecording(camera_id);
      }
    }
  }

  action_pause_video_recording({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) async {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return;
    }
    if (isMobile) {
      await camera_mobile_controller.pauseVideoRecording();
    } else if (isDesktop) {
      if (Platform.isWindows) {
        await camera_windows.pauseVideoRecording(camera_id);
      }
    }
  }

  int action_get_camera_count({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return 0;
    }
    if (isMobile) {
      return camera_mobile_datas.length;
    } else if (isDesktop) {
      if (Platform.isWindows) {
        return camera_mobile_datas.length;
      }
    }
    return 0;
  }

  int action_get_camera_id({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return 0;
    }
    if (isMobile) {
      return camera_mobile_controller.cameraId;
    } else if (isDesktop) {
      if (Platform.isWindows) {
        return camera_id;
      }
    }
    return 0;
  }

  bool action_enable_audio({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return false;
    }
    if (isMobile) {
      return camera_mobile_controller.enableAudio;
    } else if (isDesktop) {
      if (Platform.isWindows) {}
    }
    return false;
  }

  action_pause_preview({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) async {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return;
    }
    if (isMobile) {
      await camera_mobile_controller.pausePreview();
    } else if (isDesktop) {
      if (Platform.isWindows) {
        await camera_windows.pausePreview(camera_id);
      }
    }
  }

  action_resume_preview({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) async {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return;
    }
    if (isMobile) {
      await camera_mobile_controller.resumePreview();
    } else if (isDesktop) {
      if (Platform.isWindows) {
        await camera_windows.resumePreview(camera_id);
      }
    }
  }

  action_stop_video_recording({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) async {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return;
    }
    if (isMobile) {
      var res = (await camera_mobile_controller.stopVideoRecording());
    } else if (isDesktop) {
      if (Platform.isWindows) {
        await camera_windows.stopVideoRecording(camera_id);
      }
    }
  }

  Future<CameraTakePictureData?> action_take_picture({
    required void Function() onCameraNotInit,
    required void Function() onCameraNotSelect,
    required void Function() onCameraNotActive,
  }) async {
    bool is_check_camera = util_check_camera(
      onCameraNotInit: onCameraNotInit,
      onCameraNotSelect: onCameraNotSelect,
      onCameraNotActive: onCameraNotActive,
    );
    if (!is_check_camera) {
      return null;
    }
    if (isMobile) {
      var res = (await camera_mobile_controller.takePicture());

      return CameraTakePictureData(
        mimeType: res.mimeType ?? "",
        path: res.path,
        name: res.name,
      );
    } else if (isDesktop) {
      if (Platform.isWindows) {
        var res = await camera_windows.takePicture(camera_id);
        return CameraTakePictureData(
          mimeType: res.mimeType ?? "",
          path: res.path,
          name: res.name,
        );
      }
    }
    return null;
  }
}

class CameraTakePictureData {
  String mimeType;
  String path;
  String name;

  CameraTakePictureData({required this.mimeType, required this.path, required this.name});
}
