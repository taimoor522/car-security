import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';
import '../strings.dart';
import 'arrow_up.dart';

class UserGuidWhenLocked extends StatelessWidget {
  const UserGuidWhenLocked({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: blue.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: SvgPicture.asset(
              keySvg,
              width: 30,
              color: blue,
            ),
          ),
          const SizedBox(height: 10),
          const ArrowUp(),
        ],
      ),
    );
  }
}
