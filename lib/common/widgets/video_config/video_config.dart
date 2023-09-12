import 'package:flutter/material.dart';

class VideoConfigData extends InheritedWidget {
  // InheritedWidget은 앱 전체에 데이터를 공유 할 수 있지만, 업데이트 할 수는 없음.
  // 단지 데이터 제공자임.
  // StatefulWidget과 결합해주면 해결됨.
  const VideoConfigData({
    super.key,
    required super.child,
    required this.autoMute,
    required this.toggleMuted,
  });

  final bool autoMute;
  final void Function() toggleMuted;

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  // 위젯을 rebuild 할지 말지 정해줌
  // VideoConfigData 위젯을 상속하는 위젯들에게 변경된 걸 알려줄 수 있음.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    // throw UnimplementedError();
    return true;
  }
}

class VideoConfig extends StatefulWidget {
  const VideoConfig({super.key, required this.child});

  final Widget child;

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;

  void toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      autoMute: autoMute,
      toggleMuted: toggleMuted,
      child: widget.child,
    );
  }
}
