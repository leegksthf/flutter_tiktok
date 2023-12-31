// import 'package:flutter/material.dart';

// class VideoConfigData extends InheritedWidget {
// InheritedWidget은 앱 전체에 데이터를 공유 할 수 있음.
// 위젯 트리를 일일이 거치지 않고 직접적으로 데이터 받음.
// 그러나 업데이트 할 수는 없음. 단지 데이터 제공자임.
// StatefulWidget과 결합해주면 해결되지만, 변수도 일일이 작성, 전달해줘야하고 main page에 새 inheritedWidget이 생길 때마다 최상위에 덮어줘야함. 과정이 너무 장황해져서 성능에도 좋지 않음.
// 또한 main의 최상단을 감싸고있기때문에 상태가 변경될 때마다 전체 앱을 다 rebuild함.
// 따라서 데이터 읽기만 필요할 때 사용하면 좋음.
//   // => ChangeNotifier 사용하면 됨.
//   const VideoConfigData({
//     super.key,
//     required super.child,
//     required this.autoMute,
//     required this.toggleMuted,
//   });

//   final bool autoMute;
//   final void Function() toggleMuted;

//   static VideoConfigData of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
//   }

//   // 위젯을 rebuild 할지 말지 정해줌
//   // VideoConfigData 위젯을 상속하는 위젯들에게 변경된 걸 알려줄 수 있음.
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     // TODO: implement updateShouldNotify
//     // throw UnimplementedError();
//     return true;
//   }
// }

// class VideoConfig extends StatefulWidget {
//   const VideoConfig({super.key, required this.child});

//   final Widget child;

//   @override
//   State<VideoConfig> createState() => _VideoConfigState();
// }

// class _VideoConfigState extends State<VideoConfig> {
//   bool autoMute = false;

//   void toggleMuted() {
//     setState(() {
//       autoMute = !autoMute;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VideoConfigData(
//       autoMute: autoMute,
//       toggleMuted: toggleMuted,
//       child: widget.child,
//     );
//   }
// }
