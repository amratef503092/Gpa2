import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'number_of_course_state.dart';

class NumberOfCourseCubit extends Cubit<NumberOfCourseState> {
  NumberOfCourseCubit() : super(NumberOfCourseInitial());

  static NumberOfCourseCubit get(context) =>
      BlocProvider.of<NumberOfCourseCubit>(context);
  int numberOfCourse = 0;
  void add(){
    numberOfCourse++;
    emit((NumberOfCourseAddState()));
  }
  void minimize(){
    if(numberOfCourse > 0){
      numberOfCourse--;
      emit((NumberOfCourseMinimizeState()));
    }
  }
}
