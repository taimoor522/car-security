import 'package:flutter/material.dart';

import '../colors.dart';


class BottomNavbarChild extends StatelessWidget {
  const BottomNavbarChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: blue.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(Icons.key, color: Colors.white),
          ),
          const Icon(Icons.location_on_outlined, color: Colors.white),
          const Icon(Icons.settings, color: Colors.white),
          const Icon(Icons.person, color: Colors.white),
        ],
      ),
    );
  }
}
