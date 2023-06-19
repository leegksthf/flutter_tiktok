import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class TutorialScreenTabBarExample extends StatefulWidget {
  const TutorialScreenTabBarExample({super.key});

  @override
  State<TutorialScreenTabBarExample> createState() =>
      _TutorialScreenTabBarExampleState();
}

class _TutorialScreenTabBarExampleState
    extends State<TutorialScreenTabBarExample> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    'Watch cool videos!',
                    style: TextStyle(
                        fontSize: Sizes.size40, fontWeight: FontWeight.bold),
                  ),
                  Gaps.v16,
                  Text(
                    'Videos are personalized for you based on what you watch, like, and share.',
                    style: TextStyle(fontSize: Sizes.size20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    'Watch cool videos!',
                    style: TextStyle(
                        fontSize: Sizes.size40, fontWeight: FontWeight.bold),
                  ),
                  Gaps.v16,
                  Text(
                    'Videos are personalized for you based on what you watch, like, and share.',
                    style: TextStyle(fontSize: Sizes.size20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    'Watch cool videos!',
                    style: TextStyle(
                        fontSize: Sizes.size40, fontWeight: FontWeight.bold),
                  ),
                  Gaps.v16,
                  Text(
                    'Videos are personalized for you based on what you watch, like, and share.',
                    style: TextStyle(fontSize: Sizes.size20),
                  )
                ],
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size48,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TabPageSelector(
                    selectedColor: Colors.black38,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
