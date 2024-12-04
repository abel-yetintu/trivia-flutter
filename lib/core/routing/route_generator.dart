import 'package:flutter/material.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';
import 'package:trivio/features/trivia/presentation/screens/game_screen.dart';
import 'package:trivio/features/trivia/presentation/screens/trivia_customization_screen.dart';
import 'package:trivio/features/trivia/presentation/screens/welcome_screen.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case '/trivia_customization':
        return MaterialPageRoute(builder: (_) => const TriviaCustomizationScreen());
      case '/questions':
        if (args is List<Question>) {
          return MaterialPageRoute(builder: (_) => GameScreen(questions: args));
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('Route Not Found'),
        ),
      );
    });
  }
}
