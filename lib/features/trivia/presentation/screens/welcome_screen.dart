import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trivio/core/dependency_injection.dart';
import 'package:trivio/core/utils/extensions.dart';
import 'package:trivio/core/utils/helper_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .05, vertical: context.screenHeight * .02),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                  'https://lottie.host/0a0dcf90-80f3-4e5b-89c1-7997fe5a45d5/DCYoFG13mF.json',
                  height: context.screenHeight * .4,
                  width: context.screenWidth * .6,
                ),
                addVerticalSpace(context.screenHeight * .04),
                Text(
                  "It's trivia time!",
                  style: context.textTheme.headlineLarge,
                ),
                addVerticalSpace(context.screenHeight * .04),
                Text(
                  "Think fast, play smart, and have fun!",
                  style: context.textTheme.bodyLarge,
                ),
                addVerticalSpace(context.screenHeight * .04),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      sl<GlobalKey<NavigatorState>>().currentState?.pushReplacementNamed('/trivia_customization');
                    },
                    child: const Text('Get Started'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
