import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = [
  'Top',
  'Users',
  'Videos',
  'Sounds',
  'LIVE',
  'Shopping',
  'Brands',
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isWriting = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {}
  void _onSearchSubmitted(String value) {}

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  void _onStopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _clearWriting() {
    setState(() {
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          // leading: const Icon(FontAwesomeIcons.chevronLeft),
          // actions: const [Icon(FontAwesomeIcons.barsProgress)],
          title: SizedBox(
            height: 44,
            child: TextField(
              controller: _textEditingController,
              onTap: _onStartWriting,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                prefixIcon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.black,
                  size: Sizes.size20,
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 40),
                suffixIcon: GestureDetector(
                  onTap: _clearWriting,
                  child: Icon(
                    FontAwesomeIcons.solidCircleXmark,
                    color: Colors.grey.shade600,
                    size: Sizes.size20,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                ),
                hintText: 'Search',
                filled: true,
                fillColor: Colors.grey.shade200,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(Sizes.size12),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(Sizes.size12),
                ),
              ),
            ),
          ),
          // CupertinoSearchTextField(
          //   prefixIcon: const Icon(
          //     CupertinoIcons.search,
          //     color: Colors.black,
          //   ),
          //   prefixInsets: const EdgeInsets.symmetric(horizontal: 10),
          //   suffixInsets: const EdgeInsets.symmetric(horizontal: 10),
          //   padding: const EdgeInsets.symmetric(
          //     vertical: 15,
          //   ),
          //   onChanged: _onSearchChanged,
          //   onSubmitted: _onSearchSubmitted,
          // ),
          bottom: TabBar(
            // 탭 눌렀을 때 효과
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            tabs: [
              for (String tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: _onStopWriting,
          child: TabBarView(
            children: [
              GridView.builder(
                padding: const EdgeInsets.all(
                  Sizes.size6,
                ),
                itemBuilder: (context, index) => Column(
                  children: [
                    Container(
                      // 이미지가 컨테이너를 벗어나기때문에 잘라줌
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4)),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/dami6.jpeg',
                          image:
                              "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                        ),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      'This is a very long caption for my tiktok that im upload just now currently.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: Sizes.size16 + Sizes.size2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v8,
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage(
                              'assets/images/dami5.jpeg',
                            ),
                          ),
                          Gaps.h4,
                          const Expanded(
                            child: Text(
                              'My avatar is going to be very long',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size16,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          const Text(
                            '2.5M',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 9 / 20,
                ),
              ),
              for (String tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
