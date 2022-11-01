import 'package:flutter/material.dart';


class ArrowUp extends StatefulWidget {
  const ArrowUp({super.key});

  @override
  State<ArrowUp> createState() => _ArrowUpState();
}

class _ArrowUpState extends State<ArrowUp> with SingleTickerProviderStateMixin {
  late AnimationController arrowAnimationController;
  late Animation<double> largeArrowOpacityAnimation;
  late Animation<double> mediumArrowOpacityAnimation;
  late Animation<double> smallArrowOpacityAnimation;

  @override
  void initState() {
    super.initState();
    arrowAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    largeArrowOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: arrowAnimationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    mediumArrowOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: arrowAnimationController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeIn),
      ),
    );

    smallArrowOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
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
      alignment: Alignment.center,
      children: [
        Positioned(
            top: -5,
            child: Opacity(
              opacity: smallArrowOpacityAnimation.value,
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                size: 20,
              ),
            )),
        Opacity(
          opacity: mediumArrowOpacityAnimation.value,
          child: const Icon(
            Icons.keyboard_arrow_up_rounded,
            size: 25,
          ),
        ),
        Positioned(
            bottom: -10,
            child: Opacity(
                opacity: largeArrowOpacityAnimation.value,
                child: const Icon(Icons.keyboard_arrow_up_rounded, size: 30)))
      ],
    );
  }
}
