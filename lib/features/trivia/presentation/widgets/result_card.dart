import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trivio/core/dependency_injection.dart';
import 'package:trivio/core/utils/extensions.dart';
import 'package:trivio/core/utils/helper_widgets.dart';

class ResultCard extends StatelessWidget {
  final int score;
  final int numberOfQuestions;
  const ResultCard({super.key, required this.score, required this.numberOfQuestions});

  @override
  Widget build(BuildContext context) {
    final scorePercentage = ((score / numberOfQuestions) * 100).toStringAsFixed(2);
    return Card(
      elevation: 0,
      color: context.theme.colorScheme.tertiaryContainer,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .04, vertical: context.screenHeight * .02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://lottie.host/677986b5-7e97-4406-b9ce-5426eff9380e/OJromsqKIt.json',
              height: context.screenHeight * .2,
            ),
            addVerticalSpace(context.screenHeight * .02),
            Text(
              'Congrats!',
              style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            addVerticalSpace(context.screenHeight * .02),
            Text(
              '$scorePercentage% Score',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            addVerticalSpace(context.screenHeight * .02),
            Text(
              'Game compeleted successfully.',
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            addVerticalSpace(context.screenHeight * .02),
            Text(
              'You got $score questions correct out of $numberOfQuestions questions',
              textAlign: TextAlign.center,
            ),
            addVerticalSpace(context.screenHeight * .04),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  sl<GlobalKey<NavigatorState>>().currentState?.pop();
                },
                child: const Text('Finish'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
