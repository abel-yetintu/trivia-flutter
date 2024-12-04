import 'package:flutter/material.dart';
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
                Image.asset(
                  'assets/icons/trivia.png',
                  height: context.screenHeight * .2,
                  width: context.screenWidth * .4,
                ),
                addVerticalSpace(context.screenHeight * .05),
                Text(
                  "It's trivia time!",
                  style: context.textTheme.headlineLarge,
                ),
                addVerticalSpace(context.screenHeight * .05),
                Text(
                  "Think fast, play smart, and have fun!",
                  style: context.textTheme.bodyLarge,
                ),
                addVerticalSpace(context.screenHeight * .05),
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
