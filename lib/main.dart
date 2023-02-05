import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa/view/screens/splash_screen/splash_screen.dart';
import 'package:gpa/view_model/inpuit_cubit/input_cubit.dart';
import 'package:gpa/view_model/number_of_course_cubit/number_of_course_cubit.dart';
import 'package:gpa/view_model/result_cubit/result_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'firebase_options.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.
  initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return NumberOfCourseCubit();
        },),
        BlocProvider(create: (context) {
          return InputCubit();
        },),
        BlocProvider(create: (context) {
          return ResultCubit();
        },),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GPA Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

