import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

int _itemCount = 4;

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int page) {
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.teal,
      ]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // ListView.builder처럼 모든 정보를 한 번에 로딩하지 않고 현재 보고있는 것만 로딩함
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      onPageChanged: (value) => _onPageChanged(value),
      itemBuilder: (context, index) => Container(
        color: colors[index],
      ),
    );
  }
}
