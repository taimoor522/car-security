import 'package:flutter/material.dart';


class ArrowDown extends StatefulWidget {
  const ArrowDown({super.key});

  @override
  State<ArrowDown> createState() => _ArrowDownState();
}

class _ArrowDownState extends State<ArrowDown>
    with SingleTickerProviderStateMixin {
  late AnimationController arrowAnimationController;
  late Animation<double> topArrowOpacityAnimation;
  late Animation<double> centerArrowOpacityAnimation;
  late Animation<double> bottomArrowOpacityAnimation;

  @override
  void initState() {
    super.initState();
    arrowAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    topArrowOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: arrowAnimationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    centerArrowOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: arrowAnimationController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeIn),
      ),
    );

    bottomArrowOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: arrowAnimationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    arrowAnimationController.repeat(reverse: false);

    arrowAnimationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -10,
          child: Opacity(
            opacity: topArrowOpacityAnimation.value,
            child: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 30,
            ),
          ),
        ),
        Opacity(
          opacity: centerArrowOpacityAnimation.value,
          child: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 25,
          ),
        ),
        Positioned(
          bottom: -5,
          child: Opacity(
            opacity: bottomArrowOpacityAnimation.value,
            child: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
