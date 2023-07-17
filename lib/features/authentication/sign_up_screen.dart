import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const UsernameScreen()),
    );
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
                const Text(
                  'Sign up for TikTok',
                  style: TextStyle(
                      fontSize: Sizes.size24, fontWeight: FontWeight.w700),
                ),
                Gaps.v20,
                const Text(
                  'Create a profile, follow other accounts, make your own videos, and more.',
                  style:
                      TextStyle(fontSize: Sizes.size16, color: Colors.black45),
                  textAlign: TextAlign.center,
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait)
                  // 리스트에 있는 것들을 꺼내서(...) 뿌려줘라
                  ...[
                  AuthButton(
                    onTap: _onEmailTap,
                    text: 'Use email & password',
                    icon: const FaIcon(FontAwesomeIcons.user),
                  ),
                  Gaps.v16,
                  AuthButton(
                    onTap: _onEmailTap,
                    text: 'Continue with Apple',
                    icon: const FaIcon(FontAwesomeIcons.apple),
                  ),
                ],
                if (orientation == Orientation.landscape)
                  Row(children: [
                    Expanded(
                      child: AuthButton(
                        onTap: _onEmailTap,
                        text: 'Use email & password',
                        icon: const FaIcon(FontAwesomeIcons.user),
                      ),
                    ),
                    Gaps.h16,
                    Expanded(
                      child: AuthButton(
                        onTap: _onEmailTap,
                        text: 'Continue with Apple',
                        icon: const FaIcon(FontAwesomeIcons.apple),
                      ),
                    ),
                  ])
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade50,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      'Log in',
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
