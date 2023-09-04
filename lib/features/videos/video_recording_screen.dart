import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/widgets/video_flash_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = 'postVideo';
  static const String routeURL = '/upload';

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late CameraController _cameraController;
  late FlashMode _flashMode;

  double _zoomLevel = 1;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.1).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    await _cameraController.initialize();

    // 녹화준비(iOS 전용 카메라 제어 메서드 -> 이걸 안 하면 싱크가 안 맞는 경우가 종종 있기 때문)
    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording() async {
    if (_noCamera) return;
    if (_cameraController.value.isRecordingVideo) return;
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    _zoomLevel = await _cameraController.getMinZoomLevel();
    await _cameraController.setZoomLevel(_zoomLevel);
    setState(() {});

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    // 갤러리 앱 실행
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    // 참고: 내부 카메라 앱 실행
    //  final video = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (video == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  Future<void> _zoomInOut(DragUpdateDetails details) async {
    double deltaY = details.delta.dy;

    double maxZoomLevel = await _cameraController.getMaxZoomLevel();
    double minZoomLevel = await _cameraController.getMinZoomLevel();

    if (deltaY < 0) {
      _zoomLevel =
          _zoomLevel >= maxZoomLevel ? maxZoomLevel : _zoomLevel + 0.05;
    } else if (deltaY > 0) {
      _zoomLevel =
          _zoomLevel <= minZoomLevel ? minZoomLevel : _zoomLevel - 0.05;
    } else {
      return;
    }

    await _cameraController.setZoomLevel(_zoomLevel);
    setState(() {});

    // var zoomLevel = -(details.globalPosition.dy - _startPosition) / 100;

    // if (minLevel > _zoomLevel) {
    //   _cameraController.setZoomLevel(minLevel);
    //   _zoomLevel = minLevel;
    //   setState(() {});
    //   return;
    // } else if (maxLevel < _zoomLevel) {
    //   _cameraController.setZoomLevel(maxLevel);
    //   _zoomLevel = maxLevel;
    //   setState(() {});
    //   return;
    // }
    // _zoomLevel = _zoomLevel + zoomLevel;
    // print(_zoomLevel);
    // _cameraController.setZoomLevel(_zoomLevel);
    // setState(() {});

    // if (_zoomLevel > 9 || _zoomLevel < 1) return;
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    // 유저가 application에서 벗어나면 알려줌
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_noCamera) return;
    // 아직 권한을 갖고있지 않을 때
    if (!_hasPermission) return;
    // 권한 창이 application의 앞에 나타나서(flutter는 application이 비활성화됐다고 생각함)
    // cameraController가 initialized되지 않았다고 오류뜨는 것을 방지.
    if (!_cameraController.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Initializing...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v28,
                  CircularProgressIndicator.adaptive()
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(
                      _cameraController,
                    ),
                  const Positioned(
                    top: Sizes.size40,
                    left: Sizes.size20,
                    child: CloseButton(
                      color: Colors.white,
                    ),
                  ),
                  if (!_noCamera)
                    Positioned(
                      top: Sizes.size40,
                      right: Sizes.size10,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: _toggleSelfieMode,
                            icon: const Icon(
                              Icons.cameraswitch,
                            ),
                          ),
                          Gaps.v10,
                          VideoFlashButton(
                            flashMode: FlashMode.off,
                            setFlashMode: _setFlashMode,
                            icon: Icons.flash_off_rounded,
                            currentFlashMode: _flashMode,
                          ),
                          Gaps.v10,
                          VideoFlashButton(
                            flashMode: FlashMode.always,
                            setFlashMode: _setFlashMode,
                            icon: Icons.flash_on_rounded,
                            currentFlashMode: _flashMode,
                          ),
                          Gaps.v10,
                          VideoFlashButton(
                            flashMode: FlashMode.auto,
                            setFlashMode: _setFlashMode,
                            icon: Icons.flash_auto_rounded,
                            currentFlashMode: _flashMode,
                          ),
                          Gaps.v10,
                          VideoFlashButton(
                            flashMode: FlashMode.torch,
                            setFlashMode: _setFlashMode,
                            icon: Icons.flashlight_on_rounded,
                            currentFlashMode: _flashMode,
                          ),
                          Gaps.v10,
                        ],
                      ),
                    ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: Sizes.size40,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onVerticalDragUpdate: (details) =>
                              _zoomInOut(details),
                          onLongPress: _startRecording,
                          onLongPressEnd: (details) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size5,
                                  height: Sizes.size80 + Sizes.size5,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: Sizes.size10,
                            ),
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
