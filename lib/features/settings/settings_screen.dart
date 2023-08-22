import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              // adaptive: 어느 환경에서 실행하고있는지 판단해서 그에 맞게 서로 다른 UI를 보여줌.
              SwitchListTile.adaptive(
                value: _notifications,
                onChanged: _onNotificationsChanged,
                title: const Text("Enable notifications"),
                subtitle: const Text("They will be cute."),
              ),
              CheckboxListTile(
                activeColor: Colors.black,
                value: _notifications,
                onChanged: _onNotificationsChanged,
                title: const Text("Marketing emails"),
                subtitle: const Text("We won't spam you."),
              ),
              ListTile(
                onTap: () async {
                  if (!mounted) return;
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );
                  if (!mounted) return;
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (!mounted) return;
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