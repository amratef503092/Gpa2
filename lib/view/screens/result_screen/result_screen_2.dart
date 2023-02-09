import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:gpa/view_model/inpuit_cubit/input_cubit.dart';
import 'package:gpa/view_model/result_cubit/result_cubit.dart';

class ResultScreenTwo extends StatefulWidget {
  const ResultScreenTwo({Key? key}) : super(key: key);

  @override
  State<ResultScreenTwo> createState() => _ResultScreenTwoState();
}

class _ResultScreenTwoState extends State<ResultScreenTwo> {
  @override
  void initState() {
    // TODO: implement initState
    ResultCubit.get(context)
        .calculateGPA2(subjects: InputCubit
        .get(context)
        .subjects);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResultCubit, ResultState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ResultCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Result"),
          ),
          body:  SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 200,
                    height: 200,
                    child: AnimatedRadialGauge(
                      value: cubit.result,
                      duration: const Duration(seconds: 1),
                      progressBar: const GaugeRoundedProgressBar(
                        color: Colors.blueAccent,
                      ),

                      /// Optionally, you can configure your gauge, providing additional
                      /// styles and transformers.
                      axis: GaugeAxis(
                        /// Provide the [min] and [max] value for the [value] argument.
                        min: 0,
                        max: 4,
                        /// Render the gauge as a 180-degree arc.
                        degrees: 180,

                        /// Set the background color and axis thickness.
                        style: const GaugeAxisStyle(
                          thickness: 20,
                          background: Color(0xFFDFE2EC),
                        ),

                        /// Define the pointer that will indicate the progress.
                        pointer: NeedlePointer(
                          size: const Size(16, 100),
                          borderRadius: 16,
                          backgroundColor: const Color(0xFF193663),

                        ),
                      ),)),
                Text(
                  "GPA: ${
                      cubit.result.toStringAsFixed(2)
                  }",
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Total Hours: ${cubit.totalHours}",
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Grade : ${cubit.gpa2()}",
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
