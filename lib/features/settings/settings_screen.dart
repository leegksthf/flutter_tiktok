import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/theme_config/theme_config.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config_inherited_widget_test.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  final bool _notifications = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LimitedBox(
              maxWidth: min(
                Breakpoints.sm,
                MediaQuery.of(context).size.width,
              ),
              child: AppBar(
                title: const Text('Settings'),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          constraints: const BoxConstraints(
            maxWidth: Breakpoints.sm,
          ),
          child: ListView(
            children: [
              // 애니메이션 뿐만 아니라 값 변경 알림에도 사용되기때문에 changeNotifier, valueNotifier와 함께 사용.
              // 필요한 부분만 rebuild되기때문에 성능에 좋음.
              // ValueListenableBuilder 사용해도 됨.
              // AnimatedBuilder(
              //   animation: darkModeConfig,
              //   builder: (context, child) => SwitchListTile.adaptive(
              //     value: darkModeConfig.value,
              //     onChanged: (value) {
              //       darkModeConfig.value = !darkModeConfig.value;
              //     },
              //     title: const Text('DarkMode'),
              //     subtitle: const Text('apply dark mode.'),
              //   ),
              // ),
              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).darkmode,
                onChanged: (value) => {
                  ref.read(playbackConfigProvider.notifier).setDarkMode(value)
                },
                title: const Text('DarkMode'),
                subtitle: const Text('apply dark mode.'),
              ),
              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).muted,
                onChanged: (value) =>
                    {ref.read(playbackConfigProvider.notifier).setMuted(value)},
                title: const Text('Mute video'),
                subtitle: const Text('Video will be muted by default.'),
              ),
              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).autoplay,
                onChanged: (value) => {
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value)
                },
                title: const Text('Autoplay'),
                subtitle: const Text('Video will start playing automatically'),
              ),
              // SwitchListTile.adaptive(
              // watch는 변하는 프로퍼티의 값을 알고 싶을 때 사용하고, read는 변하지 않는 것을 한 번만 읽고싶을 때 사용함.
              //   value: context.watch<VideoConfig>().isMuted,
              //   onChanged: (value) =>
              //       context.read<VideoConfig>().toggleIsMuted(),
              //   title: const Text('Auto Mute'),
              //   subtitle: const Text("Videos will be muted by default."),
              // ),

              // adaptive: 어느 환경에서 실행하고있는지 판단해서 그에 맞게 서로 다른 UI를 보여줌.
              SwitchListTile.adaptive(
                value: false,
                onChanged: (value) {},
                title: const Text("Enable notifications"),
                subtitle: const Text("They will be cute."),
              ),
              CheckboxListTile(
                activeColor: Colors.black,
                value: false,
                onChanged: (value) {},
                title: const Text("Marketing emails"),
                subtitle: const Text("We won't spam you."),
              ),
              ListTile(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );

                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  final booking = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          appBarTheme: const AppBarTheme(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black),
                        ),
                        child: child!,
                      );
                    },
                  );
                },
                title: const Text("What is your birthday?"),
                subtitle: const Text("I need to know!"),
              ),
              ListTile(
                title: const Text("Log out (iOS)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("Plx dont go"),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("No"),
                        ),
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          isDestructiveAction: true,
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Log out (Android)"),
                textColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      icon: const FaIcon(FontAwesomeIcons.skull),
                      title: const Text("Are you sure?"),
                      content: const Text("Plx dont go"),
                      actions: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const FaIcon(FontAwesomeIcons.car),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Log out (iOS / Bottom)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text("Are you sure?"),
                      message: const Text("Please dooooont gooooo"),
                      actions: [
                        CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Not log out"),
                        ),
                        CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Yes plz."),
                        )
                      ],
                    ),
                  );
                },
              ),
              const AboutListTile(
                applicationVersion: "1.0",
                applicationLegalese: "Don't copy me.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
