// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print, unused_import, dead_code, use_build_context_synchronously

import 'dart:io';

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
    } catch (e, stack) {
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
      body: ConstrainedBox(
        constraints: BoxConstraints(),
        child: Stack(
          children: [
            Visibility(
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
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 1 / 5,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(102, 0, 0, 0),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                      ),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Icon(
                          Icons.more_horiz_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Future(() async {
                          var res = await cameraController.action_take_picture(
                            onCameraNotInit: () {},
                            onCameraNotSelect: () {},
                            onCameraNotActive: () {},
                          );

                          print(res?.path);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                // backgroundColor: Colors.transparent,
                                // elevation: 0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'PICTURE',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(Icons.close_rounded),
                                            color: Colors.redAccent,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.file(
                                      File(res!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        int camera_id = 1;
                        var res = cameraController.camera_mobile_datas;
                        print(cameraController.camera_id);
                        print(res.length);
                        if (cameraController.camera_id > 1) {
                          camera_id = 1;
                        } else {
                          camera_id = res.length;
                        }
                        await cameraController.action_change_camera(
                          cameraId: camera_id,
                          setState: setState,
                          mounted: () {
                            return mounted;
                          },
                          onCameraNotInit: () {},
                          onCameraNotSelect: () {},
                          onCameraNotActive: () {},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
