import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivio/core/dependency_injection.dart';
import 'package:trivio/core/routing/route_generator.dart';
import 'package:trivio/features/trivia/presentation/cubits/category/category_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/preference/preference_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/question/question_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initSL();
  runApp(const Trivio());
}

class Trivio extends StatelessWidget {
  const Trivio({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<CategoryCubit>()),
        BlocProvider(create: (_) => PreferenceCubit()),
        BlocProvider(create: (_) => sl<QuestionCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 244, 128, 30),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        navigatorKey: sl<GlobalKey<NavigatorState>>(),
        onGenerateRoute: RouteGenerator.onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}
