import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/subject_model.dart';

part 'input_state.dart';

class InputCubit extends Cubit<InputState> {
  InputCubit() : super(InputInitial());

  static InputCubit get(context) => BlocProvider.of<InputCubit>(context);
  List<String> grade = [
    "A+",
    "A",
    "A-",
    "B+",
    "B",
    "B-",
    "C+",
    "C",
    "C-",
    "D+",
    "D",
    "D-",
    "F",
  ];
  List<SubjectModel> subjects= [];
  String selectedGrade = "A+";
  void changeGrade( String value , index){
    subjects[index].grade = value;
    emit(ChangeGradeState());
  }
}
