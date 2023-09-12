import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config_inherited_widget_test.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost(
      {super.key, required this.onVideoFinished, required this.index});

  final Function onVideoFinished;
  final int index;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  // with + Mixin은 그 클래스를 복사함. 클래스의 메서드와 속성 전부 가져옴.
  // current tree가 활성화 될 때, 위젯이 화면에 보일 때만 tick하는 Ticker를 제공해줌.
  // 매 프레임마다 재생되어야하기때문에 Ticker가 필요함.
  // 여러 애니메이션 사용한다면 TickerProviderStateMixin 사용하면 됨.

  final _videoPlayerController =
      VideoPlayerController.asset('assets/videos/dami1.mp4');

  late final AnimationController _animationController;

  bool _isPaused = false;
  bool _isMuted = false;
  final _animationDuration = const Duration(milliseconds: 200);

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      _isMuted = true;
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this, // offscreen 애니메이션의 불필요한 리소스 사용을 막는 역할
      duration: _animationDuration,
      value: 1.5,
      lowerBound: 1.0,
      upperBound: 1.5,
    );

    // ChangeNotifier 사용
    // videoConfig.addListener(() {
    //   setState(() {
    //     // _autoMute = videoConfig.autoMute;
    //     _autoMute = videoConfig.value;
    //   });
    // });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (info.visibleFraction == 0 && _videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // 이 모달창의 배경색은 디폴트값인 흰색이었는데, 투명으로 바꿔도 흰색인 이유는 Scaffold의 배경색이 나타난 것임.
      // 따라서 BorderRadius를 Scaffold한테 주면 먹게되는 것
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  void _onToggleMutedButton() {
    // if (_autoMute) {
    //   _videoPlayerController.setVolume(1.0);
    // } else {
    //   _videoPlayerController.setVolume(0.0);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                // rebuild 해주는 방법
                // child: AnimateBuilder(
                //          animation: _animationController,
                //          builder: (context, child) {
                //              return Transform.scale(
                //                scale: _animationController.value,
                //                child: child,
                //              ),
                //         },
                // )
                child: AnimatedOpacity(
                  opacity: _isPaused ? 1 : 0,
                  duration: _animationDuration,
                  child: ScaleTransition(
                    scale: _animationController,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
                icon: FaIcon(
                  context.watch<VideoConfig>().isMuted
                      ? FontAwesomeIcons.volumeOff
                      : FontAwesomeIcons.volumeHigh,
                  // VideoConfigData.of(context).autoMute
                  //     ? FontAwesomeIcons.volumeOff
                  //     : FontAwesomeIcons.volumeHigh,
                  color: Colors.white,
                ),
                onPressed: () {
                  _onToggleMutedButton();
                  context.read<VideoConfig>().toggleIsMuted();
                  // videoConfig.toggleAutoMute(); => InheritedWidget
                  // videoConfig.value = !videoConfig.value => ValueNotifier;
                }
                // VideoConfigData.of(context).toggleMuted,
                ),
          ),
          const Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@니꼬',
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  'This is my cat!!!',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                Gaps.v24,
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/3612017',
                  ),
                  child: Text('니꼬'),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(354684651),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(95121548),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: 'Share',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
