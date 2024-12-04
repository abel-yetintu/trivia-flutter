import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:trivio/core/dependency_injection.dart';
import 'package:trivio/core/enums/difficulty_enum.dart';
import 'package:trivio/core/enums/question_type_enum.dart';
import 'package:trivio/core/utils/extensions.dart';
import 'package:trivio/core/utils/helper_widgets.dart';
import 'package:trivio/core/utils/trivia_request_params.dart';
import 'package:trivio/features/trivia/domain/entities/trivia_category.dart';
import 'package:trivio/features/trivia/presentation/cubits/category/category_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/category/category_state.dart';
import 'package:trivio/features/trivia/presentation/cubits/preference/preference_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/question/question_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/question/question_state.dart';

class TriviaCustomizationScreen extends StatefulWidget {
  const TriviaCustomizationScreen({super.key});

  @override
  State<TriviaCustomizationScreen> createState() => _TriviaCustomizationScreenState();
}

class _TriviaCustomizationScreenState extends State<TriviaCustomizationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .05, vertical: context.screenHeight * .02),
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              switch (state) {
                case CategoryInitial():
                  return Container();
                case CategoryLoading():
                  return _loadingUI(context);
                case CategoryFetched():
                  return _preferencesUI(context, state.categories);
                case CategoryError():
                  return _errorUI(context, state.message);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _loadingUI(BuildContext context) {
    return Center(
      child: SpinKitSquareCircle(
        color: context.theme.colorScheme.primary,
        size: context.screenWidth * .2,
      ),
    );
  }

  Widget _preferencesUI(BuildContext context, List<TriviaCategory> categories) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Preference selection
          BlocBuilder<PreferenceCubit, TriviaRequestParams>(builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category selection

                Text(
                  'Category',
                  style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(context.screenHeight * .02),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .02),
                      value: state.category,
                      isExpanded: true,
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context.read<PreferenceCubit>().chooseCategory(category: value!);
                      },
                    ),
                  ),
                ),
                addVerticalSpace(context.screenHeight * .02),

                // Difficulty selection

                Text(
                  'Difficulty',
                  style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(context.screenHeight * .02),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .02),
                      value: state.difficulty,
                      isExpanded: true,
                      items: Difficulty.values.map((difficulty) {
                        return DropdownMenuItem(
                          value: difficulty,
                          child: Text(difficulty.name.capitalize()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context.read<PreferenceCubit>().chooseDifficulty(diffculty: value!);
                      },
                    ),
                  ),
                ),
                addVerticalSpace(context.screenHeight * .02),

                // Question Type selection

                Text(
                  'Question Type',
                  style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(context.screenHeight * .02),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .02),
                      value: state.type,
                      isExpanded: true,
                      items: QuestionType.values.map((questionType) {
                        return DropdownMenuItem(
                          value: questionType,
                          child: Text(questionType.displayName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context.read<PreferenceCubit>().chooseQuestionType(questionType: value!);
                      },
                    ),
                  ),
                ),
                addVerticalSpace(context.screenHeight * .02),

                // Amount

                Text(
                  'Amount',
                  style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(context.screenHeight * .02),
                InputQty.int(
                  initVal: state.amount,
                  maxVal: 50,
                  minVal: 1,
                  steps: 1,
                  onQtyChanged: (value) {
                    context.read<PreferenceCubit>().chooseAmount(amount: value);
                  },
                  decoration: QtyDecorationProps(
                    width: (context.screenWidth * .05).round(),
                    isBordered: false,
                    borderShape: BorderShapeBtn.circle,
                  ),
                ),
                addVerticalSpace(context.screenHeight * .04),
              ],
            );
          }),

          // Begin button

          BlocConsumer<QuestionCubit, QuestionState>(
            listener: (context, state) async {
              // Navigate when state is in fetched state
              if (state is QuestionsFetched) {
                sl<GlobalKey<NavigatorState>>().currentState?.pushNamed('/questions', arguments: state.questions);
              }
              if (state is QuestionsFailed) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: state is QuestionsLoading
                      ? () {}
                      : () {
                          context.read<QuestionCubit>().getTriviaQuestions(params: context.read<PreferenceCubit>().state);
                        },
                  child: state is QuestionsLoading
                      ? SpinKitThreeBounce(
                          color: context.theme.colorScheme.primaryContainer,
                          size: 25,
                        )
                      : const Text('Begin'),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _errorUI(BuildContext context, String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        addVerticalSpace(context.screenHeight * .02),
        FilledButton(
          onPressed: () {
            context.read<CategoryCubit>().fetchCategories();
          },
          child: const Text('Retry'),
        )
      ],
    );
  }
}
