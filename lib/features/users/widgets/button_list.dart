import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ButtonList extends StatelessWidget {
  const ButtonList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
            horizontal: Sizes.size64,
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
    );
  }
}
