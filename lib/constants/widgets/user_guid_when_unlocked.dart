import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';
import '../strings.dart';
import 'arrow_down.dart';

class UserGuidWhenUnlocked extends StatelessWidget {
  const UserGuidWhenUnlocked({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Column(
        children: [
          const ArrowDown(),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: red.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: SvgPicture.asset(
              lockSvg,
              width: 30,
              color: red,
            ),
          ),
        ],
      ),
    );
  }
}
