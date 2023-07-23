import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
