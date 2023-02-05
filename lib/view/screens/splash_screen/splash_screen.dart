import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{
@override
  void initState() {

  Future.delayed(const Duration(seconds: 3),()
  {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)
        {
          return const HomeScreen();
        },),
            (route) => false);
  });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [
            const Image(image: AssetImage("assets/logo.jpg"),
              width: 250,
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 1500),
              child: const Text("GPA Calculator",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
