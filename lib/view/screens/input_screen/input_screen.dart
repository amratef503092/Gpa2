import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa/view_model/inpuit_cubit/input_cubit.dart';
import 'package:gpa/view_model/number_of_course_cubit/number_of_course_cubit.dart';

import '../../../model/subject_model.dart';
import '../result_screen/result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < NumberOfCourseCubit.get(context).numberOfCourse; i++)
    {
      InputCubit.get(context).
      subjects.add(
          SubjectModel(
            hours: 0,
            grade: "A+",
            gradePoint: 4.0,
          ));
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ResultScreen();
            },));
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.infinity, 50),
          ),
          child: const Text(
            "Submit",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
        appBar: AppBar(
          title: const Text("GPA Calculator"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right:  15 , bottom: 60),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: "Subject"),
                      const SizedBox(
                        width: 20,
                      ),
                      customText(text: "Hours"),
                      const SizedBox(
                        width: 20,
                      ),
                      customText(text: "Grade"),
                      const SizedBox(
                        width: 20,
                      ),
                      customText(text: "Points"),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index)
                    {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount:
                    NumberOfCourseCubit.get(context).
                    numberOfCourse,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                              width: 50,
                              child:
                              customText(text: "Course ${index + 1}",
                                  fontSize: 12)),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              initialValue: InputCubit.get(context).subjects[index].hours.toString(),
                              onChanged: (value)
                              {
                                if (value.isNotEmpty)
                                {
                                  InputCubit.get(context).subjects[index].hours = int.parse(value);
                                }else{
                                  InputCubit.get(context).subjects[index].hours = 0;
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          BlocBuilder<InputCubit, InputState>(
                            builder: (context, state) {
                              return SizedBox(
                                width: 70,
                                child: DropdownButton(
                                    isExpanded: true,
                                    hint: const Text("Select Grade"),
                                    value: InputCubit.get(context).subjects[index].grade,
                                    items: InputCubit.get(context).grade.map((e)
                                    {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                    onChanged: (value)
                                    {
                                      InputCubit.get(context).changeGrade(value as String , index);
                                    }),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              onChanged: (value) {
                                if(value.isEmpty)
                                {
                                  InputCubit.get(context).subjects[index].gradePoint = 0;

                                }else{
                                  InputCubit.get(context).subjects[index].gradePoint = double.parse(value);

                                }
                              },
                              initialValue: InputCubit.get(context).subjects[index].gradePoint.toString(),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Text customText({required String text, double? fontSize}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
