class SubjectModel {
    int hours;
   String grade;
   double gradePoint;
   double totalGradePoint;

  SubjectModel(
      {required this.hours,
       required this.grade,
       required this.gradePoint,
        this.totalGradePoint = 0.0
      });
}
