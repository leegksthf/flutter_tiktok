import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoFlashButton extends StatelessWidget {
  final FlashMode currentFlashMode;
  final FlashMode flashMode;
  final Function setFlashMode;
  final IconData icon;

  const VideoFlashButton({
    super.key,
    required this.flashMode,
    required this.setFlashMode,
    required this.icon,
    required this.currentFlashMode,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color:
          currentFlashMode == flashMode ? Colors.amber.shade300 : Colors.white,
      onPressed: () => setFlashMode(flashMode),
      icon: Icon(
        icon,
      ),
    );
  }
}
