import 'package:code/colors.dart';
import 'package:code/lock_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'container_clipper.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const App(),
    ),
  );
}

ValueNotifier<LockState> lockStateNotifier = ValueNotifier(LockState.unlocked);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: SizedBox(
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
                        offset: const Offset(0, 0),
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
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  radius: 1,
                  colors: [
                    grey,
                    Colors.black,
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: ContainerClipper(),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    tileMode: TileMode.repeated,
                    colors: [
                      darkGrey,
                      grey,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.bluetooth_connected,
                          color: blue,
                        ),
                        SizedBox(width: 10),
                        Text('Connected', style: TextStyle(fontSize: 18))
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/bmw.svg',
                      height: 60,
                    ),
                    const Button(),
                    ValueListenableBuilder<LockState>(
                        valueListenable: lockStateNotifier,
                        builder: (context, lockState, child) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              lockState.value,
                              style: const TextStyle(),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late final AnimationController buttonAnimationController;
  late final Animation<Alignment> buttonAnimation;

  @override
  void initState() {
    super.initState();
    buttonAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    buttonAnimation = CurvedAnimation(
            parent: buttonAnimationController, curve: Curves.easeInOut)
        .drive(AlignmentTween(
            begin: Alignment.topCenter, end: Alignment.bottomCenter));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(10, 5),
          ),
        ],
        gradient: const RadialGradient(
          focalRadius: 0.5,
          radius: 1.2,
          colors: [
            grey,
            darkGrey,
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        width: 110,
        height: 240,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Colors.black,
        ),
        child: ValueListenableBuilder<LockState>(
            valueListenable: lockStateNotifier,
            builder: (context, lockState, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  if (lockState == LockState.locked) const UserGuidWhenLocked(),
                  if (lockState == LockState.unlocked)
                    const UserGuidWhenUnlocked(),
                  AnimatedBuilder(
                      animation: buttonAnimationController,
                      builder: (_, __) {
                        return Align(
                          alignment: buttonAnimation.value,
                          child: GestureDetector(
                            onPanUpdate: (dragUpdateDetails) {
                              if (dragUpdateDetails.delta.dy > 0 &&
                                  lockState == LockState.unlocked) {
                                buttonAnimationController.forward();
                                Future.delayed(const Duration(seconds: 1), () {
                                  lockStateNotifier.value = LockState.locked;
                                });
                              } else if (dragUpdateDetails.delta.dy < 0 &&
                                  lockState == LockState.locked) {
                                buttonAnimationController.reverse();
                                Future.delayed(const Duration(seconds: 1), () {
                                  lockStateNotifier.value = LockState.unlocked;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: lockState == LockState.locked
                                      ? [
                                          red,
                                          redDark,
                                        ]
                                      : [
                                          blue,
                                          blueDark,
                                        ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: lockState == LockState.locked
                                          ? red.withOpacity(0.2)
                                          : blue.withOpacity(0.2),
                                      blurRadius: 20,
                                      spreadRadius: 10,
                                      offset: const Offset(0, 0)),
                                ],
                              ),
                              child: lockState == LockState.locked
                                  ? SvgPicture.asset(
                                      'assets/lock.svg',
                                      width: 30,
                                      color: Colors.white,
                                    )
                                  : SvgPicture.asset(
                                      'assets/key.svg',
                                      width: 30,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        );
                      }),
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    buttonAnimationController.dispose();
    super.dispose();
  }
}

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
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: SvgPicture.asset(
              'assets/lock.svg',
              width: 30,
              color: red,
            ),
          ),
        ],
      ),
    );
  }
}

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
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: SvgPicture.asset(
              'assets/key.svg',
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
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

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

    arrowAnimationController.addListener(() {
      setState(() {});
    });
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
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

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

    arrowAnimationController.addListener(() {
      setState(() {});
    });
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
