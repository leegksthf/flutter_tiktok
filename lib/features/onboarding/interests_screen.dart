import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/interest_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final _scrollController = ScrollController();
  bool _showTitle = false;

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      // if (!_showTitle) return;
      setState(
        () {
          _showTitle = false;
        },
      );
    }
  }

  final GlobalKey _showTitleTargetKey = GlobalKey();
  final GlobalKey _appBarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // RenderBox는 위젯의 크기 및 위치 정보를 제공하는 Flutter의 렌더링 개체.
      final RenderBox renderBox =
          // findRenderObject는 주어진 'BuildContext'에서 실제로 렌더링되는 위젯의 렌더링 객체를 찾아 반환함.
          // as RenderBox는 앞에 적인 데이터를 RenderBox 타입으로 변환시키는 명령어(형변환)
          _showTitleTargetKey.currentContext!.findRenderObject()! as RenderBox;
      // localToGlobal은 Offset.zero 즉, 로컬 위치(위젯의 최상단)을 기준으로 전역 위치를 구하는 방식.
      // 이를 통해 앱 바와 대상 위젯 사이의 상대적인 위치를 구할 수 있음.
      final targetPosition = renderBox.localToGlobal(Offset.zero);
      final appBarSize =
          (_appBarKey.currentContext!.findRenderObject()! as RenderBox)
              .size
              .height;
      //대상 위젯과 앱 바 사이의 상대적인 위치를 계산하여 position 변수에 할당.
      final position = targetPosition.dy - appBarSize;

      if (position < 0) {
        if (_showTitle) return;
        setState(() {
          _showTitle = true;
        });
      } else {
        setState(() {
          _showTitle = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const TutorialScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: const Text('Choose your interests'),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
              right: Sizes.size24,
              left: Sizes.size24,
              bottom: Sizes.size16,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Choose your interests',
                style: TextStyle(
                  fontSize: Sizes.size40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v24,
              const Text(
                'Get better video recommendations',
                style: TextStyle(
                  fontSize: Sizes.size20,
                ),
              ),
              SizedBox(
                key: _showTitleTargetKey,
              ),
              Gaps.v64,
              Wrap(
                runSpacing: 15,
                spacing: 15,
                children: [
                  for (var interest in interests)
                    InterestButton(interest: interest)
                ],
              )
            ]),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size40,
            top: Sizes.size16,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          // CupertinoButton(
          //  onPressed: (){},
          //  child: Text('Next),
          //  color: Theme.of(context).primaryColor
          // )
          child: GestureDetector(
            onTap: onNextTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Next',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
