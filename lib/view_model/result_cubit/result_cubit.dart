import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/subject_model.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());
  static ResultCubit get(context) => BlocProvider.of<ResultCubit>(context);
  double result = 0.0;
  double totalHours = 0.0;
  double totalGrade = 0.0;
  void calculateGPA({
   required List<SubjectModel> subjects,
})
  {
    result = 0.0;
   totalHours = 0.0;
   totalGrade = 0.0;
    for (var element in subjects) {
      totalHours +=element.hours;
      element.totalGradePoint = element.hours * element.gradePoint;
    }
    for (var element in subjects) {
      totalGrade += element.totalGradePoint;
    }
    result = totalGrade / totalHours;
    emit(CalculateResultState());
  }
  String gpa()
  {
    if(result >= 4.0) {
      return "A+";
    } else if(result >= 3.75) {
      return "A";
    } else if(result >= 3.5) {
      return "A-";
    } else if(result >= 3.25) {
      return "B+";
    } else if(result >= 3.0) {
      return "B";
    } else if(result >= 2.75) {
      return "B-";
    } else if(result >= 2.5) {
      return "C+";
    } else if(result >= 2.25) {
      return "C";
    } else if(result >= 2.0) {
      return "C-";
    } else if(result >= 1.75) {
      return "D+";
    } else if(result >= 1.5) {
      return "D";
    } else if(result >= 1.25) {
      return "D-";
    } else {
      return "F";
    }
  }
}
