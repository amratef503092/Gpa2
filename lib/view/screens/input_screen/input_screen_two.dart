import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa/view_model/inpuit_cubit/input_cubit.dart';
import 'package:gpa/view_model/number_of_course_cubit/number_of_course_cubit.dart';

import '../../../model/grade_model/grade_model.dart';
import '../../../model/subject_model.dart';
import '../result_screen/result_screen.dart';
import '../result_screen/result_screen_2.dart';

class InputScreenTwo extends StatefulWidget {
  const InputScreenTwo({Key? key}) : super(key: key);

  @override
  State<InputScreenTwo> createState() => _InputScreenTwoState();
}

class _InputScreenTwoState extends State<InputScreenTwo> {
  @override
  void initState() {
    // TODO: implement initState
    InputCubit.get(context).subjects.clear();

    for (int i = 0; i < NumberOfCourseCubit.get(context).numberOfCourse; i++) {
      InputCubit.get(context).subjects.add(SubjectModel(
        hours: 3,
        grade: "A+",
        gradePoint: 4.0,
      ));
    }

    super.initState();
  }

  List<GradeModel> grade = [
    GradeModel(
      grade: "A+",
      gradePoint: 4.0,
    ),
    GradeModel(
      grade: "A",
      gradePoint: 3.7,
    ),
    GradeModel(
      grade: "A-",
      gradePoint: 3.4,
    ),
    GradeModel(
      grade: "B+",
      gradePoint: 3.2,
    ),
    GradeModel(
      grade: "B",
      gradePoint: 3.0,
    ),
    GradeModel(
      grade: "B-",
      gradePoint: 2.8,
    ),
    GradeModel(
      grade: "C+",
      gradePoint: 2.6,
    ),
    GradeModel(
      grade: "C",
      gradePoint: 2.4,
    ),
    GradeModel(
      grade: "C-",
      gradePoint: 2.2,
    ),
    GradeModel(
      grade: "D+",
      gradePoint: 2,
    ),
    GradeModel(
      grade: "D",
      gradePoint: 1.5,
    ),
    GradeModel(
      grade: "D-",
      gradePoint: 1.0,
    ),
    GradeModel(
      grade: "F",
      gradePoint: 0.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const ResultScreenTwo();
                },
              ));
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
        endDrawer: Drawer(

          child: ListView.builder(
            itemCount: grade.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("${grade[index].grade} : ${grade[index].gradePoint}"),
              );
            },),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 60),
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
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: NumberOfCourseCubit.get(context).numberOfCourse,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 50,
                              child: customText(
                                  text: "Course ${index + 1}", fontSize: 12)),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              // initialValue: InputCubit.get(context).subjects[index].hours.toString(),
                              controller: TextEditingController(
                                  text: InputCubit.get(context)
                                      .subjects[index]
                                      .hours
                                      .toString()),

                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  InputCubit.get(context)
                                      .subjects[index]
                                      .hours = int.parse(value);
                                } else {
                                  InputCubit.get(context)
                                      .subjects[index]
                                      .hours = 0;
                                }
                              },
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
                                    value: InputCubit.get(context)
                                        .subjects[index].grade,
                                    items:
                                    grade.map((e) {
                                      return DropdownMenuItem(
                                        value: e.grade,
                                        child: Text(e.grade),
                                      );
                                    }).toList(),
                                    onChanged: (value)
                                    {
                                      setState(() {
                                        InputCubit.get(context)
                                            .subjects[index]
                                            .grade = value.toString();
                                        InputCubit.get(context)
                                            .subjects[index]
                                            .gradePoint = grade.firstWhere((element) => element.grade == value.toString()).gradePoint;

                                      });

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
                                if (value.isEmpty) {
                                  InputCubit.get(context)
                                      .subjects[index]
                                      .gradePoint = 0;
                                } else {
                                  InputCubit.get(context)
                                      .subjects[index]
                                      .gradePoint = double.parse(value);
                                }
                              },
                              enabled: false,
                              controller: TextEditingController(
                                  text: InputCubit.get(context)
                                      .subjects[index]
                                      .gradePoint
                                      .toString()),
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
