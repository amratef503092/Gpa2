import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa/view_model/number_of_course_cubit/number_of_course_cubit.dart';

import '../input_screen/input_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: ()
            {
              if(NumberOfCourseCubit.get(context).numberOfCourse > 0)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const InputScreen();
                },));
              }else
              {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please add at least one course"),
                    backgroundColor: Colors.red,
                    )
                );
              }

            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Next",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("GPA Calculator"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             BlocBuilder<NumberOfCourseCubit , NumberOfCourseState>(builder: (context, state) {
              return Text(
                "Number of courses: ${NumberOfCourseCubit.get(context).numberOfCourse}",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              );
            },),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: () {
                  NumberOfCourseCubit.get(context).minimize();

                }, icon: const Icon(Icons.minimize)),
                BlocBuilder<NumberOfCourseCubit, NumberOfCourseState>(
                  builder: (context, state)
                  {
                    var cubit = NumberOfCourseCubit.get(context);
                    return Text(cubit.numberOfCourse.toString());
                  },
                ),
                IconButton(onPressed: () {
                  NumberOfCourseCubit.get(context).add();
                }, icon: const Icon(Icons.add)),
              ],
            ),
          ],
        ));
  }
}
