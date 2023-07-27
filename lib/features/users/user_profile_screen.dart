import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/button_list.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/profile_info.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onSettingsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        // 그냥 CustomScrollView를 사용했을 때는 Sliver와 ScrollView가 합쳐졌을 때 비정상적인 scroll 작동이 됨.
        // CustomScrollView는 내부에 Sliver 위젯만 가능.
        // NestedScrollView: 여러개의 스크롤 가능한 View를 넣을 수 있게 해주는 위젯.
        // 모든 scroll position들을 연결시켜줌.
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              elevation: 1,
              title: const Text('한솔'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: IconButton(
                    onPressed: _onSettingsTap,
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: width > Breakpoints.md
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              // maxWidth: min(Breakpoints.lg, width), // ConstrainedBox 사용 할 때는 이 속성 사용해주면 됨.
                              maxWidth: Breakpoints.lg,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size52,
                                vertical: Sizes.size24,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 80,
                                    foregroundImage:
                                        AssetImage('assets/images/dami2.jpeg'),
                                    child: Text(
                                      '다미',
                                    ),
                                  ),
                                  Gaps.h60,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              '@hansol',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Sizes.size18,
                                              ),
                                            ),
                                            Gaps.h5,
                                            FaIcon(
                                              FontAwesomeIcons.solidCircleCheck,
                                              size: Sizes.size16,
                                              color: Colors.blue.shade500,
                                            ),
                                          ],
                                        ),
                                        Gaps.v16,
                                        const SizedBox(
                                          height: Sizes.size52,
                                          child: ProfileInfo(),
                                        ),
                                        Gaps.v10,
                                        const SizedBox(
                                          height: Sizes.size52,
                                          width: 280,
                                          child: ButtonList(),
                                        ),
                                        Gaps.v20,
                                        Row(
                                          children: const [
                                            Expanded(
                                              child: Text(
                                                '안녕하세요. 틱톨앱 클론코딩 중이에요. 플러터 재밌서요,, 재밌서요,,,안녕하세요. 틱톨앱 클론코딩 중이에요. 플러터 재밌서요,, 재밌서요,,안녕하세요. 틱톨앱 클론코딩 중이에요. 플러터 재밌서요,, 재밌서요,,',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gaps.v10,
                                        Row(
                                          children: const [
                                            FaIcon(
                                              FontAwesomeIcons.link,
                                              size: Sizes.size12,
                                            ),
                                            Gaps.h4,
                                            Text(
                                              'https://github.com/leegksthf',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gaps.v20,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: Breakpoints.lg,
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            foregroundImage:
                                AssetImage('assets/images/dami2.jpeg'),
                            child: Text(
                              '다미',
                            ),
                          ),
                          Gaps.v20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '@hansol',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.size18,
                                ),
                              ),
                              Gaps.h5,
                              FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                size: Sizes.size16,
                                color: Colors.blue.shade500,
                              )
                            ],
                          ),
                          Gaps.v24,
                          const SizedBox(
                            height: Sizes.size52,
                            child: ProfileInfo(),
                          ),
                          Gaps.v14,
                          Gaps.v14,
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.size32,
                                ),
                                child: Text(
                                  '안녕하세요. 틱톨앱 클론코딩 중이에요. 플러터 재밌서요,, 재밌서요,,,',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Gaps.v14,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.link,
                                    size: Sizes.size12,
                                  ),
                                  Gaps.h4,
                                  Text(
                                    'https://github.com/leegksthf',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Gaps.v20,
                        ],
                      ),
                    ),
            ),
            SliverPersistentHeader(
              delegate: PersistentTabBar(),
              pinned: true,
            ),
          ],
          body: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.lg,
            ),
            child: TabBarView(
              children: [
                GridView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => AspectRatio(
                    aspectRatio: 9 / 14,
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(fit: StackFit.expand, children: [
                            FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: 'assets/images/dami6.jpeg',
                              image:
                                  "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                            ),
                            Positioned(
                              bottom: 0,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.play_arrow_outlined,
                                    size: Sizes.size32,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '4.1M',
                                    style: TextStyle(
                                      fontSize: Sizes.size18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width > Breakpoints.lg ? 5 : 3,
                    crossAxisSpacing: Sizes.size2,
                    mainAxisSpacing: Sizes.size2,
                    childAspectRatio: 9 / 14,
                  ),
                ),
                const Center(
                  child: Text('Page 2'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
