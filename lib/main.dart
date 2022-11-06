import 'package:code/constants/colors.dart';
import 'package:code/constants/strings.dart';
import 'package:code/lock_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'background_clipper.dart';
import 'constants/widgets/animated_button.dart';
import 'constants/widgets/botton_navbar_child.dart';

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
        bottomNavigationBar:
            const BottomAppBar(color: black, child: BottomNavbarChild()),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient:
                    RadialGradient(radius: 1, colors: [grey, black]),
              ),
            ),
            ClipPath(
              clipper: BackgroundClipper(),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    tileMode: TileMode.repeated,
                    colors: [darkGrey, grey],
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
                    SvgPicture.asset(bmwSvg, height: 60),
                    const AnimatedButton(),
                    ValueListenableBuilder<LockState>(
                        valueListenable: lockStateNotifier,
                        builder: (_, lockState, __) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(lockState.value),
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
