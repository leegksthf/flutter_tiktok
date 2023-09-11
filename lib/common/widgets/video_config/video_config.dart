import 'package:flutter/material.dart';

class VideoConfig extends InheritedWidget {
  const VideoConfig({
    super.key,
    required super.child,
  });

  final bool autoMute = false;

  static VideoConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfig>()!;
  }

  // 위젯을 rebuild 할지 말지 정해줌
  // VideoConfig 위젯을 상속하는 위젯들에게 변경된 걸 알려줄 수 있음.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    // throw UnimplementedError();
    return true;
  }
}
