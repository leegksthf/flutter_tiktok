import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';

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
        ));
  }

  @override
  Widget build(BuildContext context) {
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
              title: const Text('니꼬'),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: IconButton(
                      onPressed: _onSettingsTap,
                      icon: const FaIcon(
                        FontAwesomeIcons.gear,
                        size: Sizes.size20,
                      ),
                    )),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    foregroundImage: AssetImage('assets/images/dami2.jpeg'),
                    child: Text(
                      '니꼬',
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
                  SizedBox(
                    height: Sizes.size52,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '50',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size18,
                              ),
                            ),
                            Gaps.v3,
                            Text(
                              'Following',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            )
                          ],
                        ),
                        VerticalDivider(
                          width: Sizes.size32,
                          thickness: 1,
                          color: Colors.grey.shade400,
                          indent: Sizes.size14,
                          endIndent: Sizes.size14,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '10M',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size18,
                              ),
                            ),
                            Gaps.v3,
                            Text(
                              'Followers',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            )
                          ],
                        ),
                        VerticalDivider(
                          width: Sizes.size32,
                          thickness: 1,
                          color: Colors.grey.shade400,
                          indent: Sizes.size14,
                          endIndent: Sizes.size14,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '194.3M',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size18,
                              ),
                            ),
                            Gaps.v3,
                            Text(
                              'Likes',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Gaps.v14,
                  SizedBox(
                    height: Sizes.size52,
                    width: 280,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.size14,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  Sizes.size4,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Follow',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Gaps.h4,
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.grey.shade300,
                          )),
                          child: const Padding(
                            padding: EdgeInsets.all(Sizes.size12),
                            child: FaIcon(
                              FontAwesomeIcons.youtube,
                            ),
                          ),
                        ),
                        Gaps.h4,
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.grey.shade300,
                          )),
                          child: const Padding(
                            padding: EdgeInsets.all(Sizes.size12),
                            child: Icon(
                              Icons.arrow_drop_down_outlined,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
            SliverPersistentHeader(
              delegate: PersistentTabBar(),
              pinned: true,
            ),
          ],
          body: TabBarView(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
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
    );
  }
}
