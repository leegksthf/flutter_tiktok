import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              const Text(
                'Log in to TikTok',
                style: TextStyle(
                    fontSize: Sizes.size24, fontWeight: FontWeight.w700),
              ),
              Gaps.v20,
              const Text(
                'Manage your account. check notifications comment on videos, and more',
                style: TextStyle(fontSize: Sizes.size16, color: Colors.black45),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              AuthButton(
                text: 'Use email & password',
                icon: const FaIcon(FontAwesomeIcons.user),
                onTap: _onLoginTap,
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Apple',
                icon: const FaIcon(FontAwesomeIcons.apple),
                onTap: _onLoginTap,
              ),
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
                  'Dont have an account?',
                ),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
