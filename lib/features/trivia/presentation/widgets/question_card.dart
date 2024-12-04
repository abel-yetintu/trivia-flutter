import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:trivio/core/utils/extensions.dart';
import 'package:trivio/core/utils/helper_widgets.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';
import 'package:trivio/features/trivia/presentation/widgets/option_tile.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          HtmlUnescape().convert(question.question),
          style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        addVerticalSpace(context.screenHeight * .04),
        Column(
          children: question.options
              .map(
                (option) => Container(
                  margin: EdgeInsets.only(bottom: context.screenHeight * .02),
                  child: OptionTile(option: option),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
