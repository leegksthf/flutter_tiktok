import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UsernameScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation =
              Tween(begin: const Offset(0, -1), end: Offset.zero)
                  .animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (context) => const UsernameScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
            child: Column(
              children: [
                Gaps.v80,
                Text(
                  S.of(context).signUpTitle("TikTok", DateTime.now()),
                  style: const TextStyle(
                      fontSize: Sizes.size24, fontWeight: FontWeight.w700),
                ),
                Gaps.v20,
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    S.of(context).signUpSubTitle,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait)
                  // 리스트에 있는 것들을 꺼내서(...) 뿌려줘라
                  ...[
                  AuthButton(
                    onTap: _onEmailTap,
                    text: S.of(context).emailPasswordButton,
                    icon: const FaIcon(FontAwesomeIcons.user),
                  ),
                  Gaps.v16,
                  AuthButton(
                    onTap: _onEmailTap,
                    text: S.of(context).appleButton,
                    icon: const FaIcon(FontAwesomeIcons.apple),
                  ),
                ],
                if (orientation == Orientation.landscape)
                  Row(children: [
                    Expanded(
                      child: AuthButton(
                        onTap: _onEmailTap,
                        text: S.of(context).emailPasswordButton,
                        icon: const FaIcon(FontAwesomeIcons.user),
                      ),
                    ),
                    Gaps.h16,
                    Expanded(
                      child: AuthButton(
                        onTap: _onEmailTap,
                        text: S.of(context).appleButton,
                        icon: const FaIcon(FontAwesomeIcons.apple),
                      ),
                    ),
                  ])
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            color: isDarkMode(context) ? null : Colors.grey.shade50,
            // material3에서 shadow 넣고싶으면 elevation 대신 직접 넣어줘야함
            // elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).alreadyHaveAnAccount,
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).login("male"),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
