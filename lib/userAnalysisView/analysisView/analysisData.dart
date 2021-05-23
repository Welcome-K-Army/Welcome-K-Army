enum AdmissionType { principal, aptitude, comprehensive, merit, village, needy, foreigner }

class AnalysisData {
  UID uid = UID();
  AdmissionType type;
  FirstExam firstExam = FirstExam();
  Body body = Body();
  Interview interview = Interview();
  Health health = Health();
  Grade grade = Grade();
  K_SAT k_SAT = K_SAT;
  Point point = Point();

  AnalysisData({this.uid, this.type});
}

class UID {
  dynamic uid = 0;

  UID();
}

class FirstExam {
  dynamic score = 0;
  List<double> languageScores;
  List<double> englishScores;
  List<double> mathScores;

  FirstExam({this.languageScores, this.englishScores, this.mathScores}) {
    print("success");
  }
}

class Body {
  bool pass = false;

  Body();
}

class Interview {
  int score = 0;

  Interview();
}

class Health {
  int score = 0;

  Health();
}

class Grade {
  int score = 0;

  Grade();
}

class K_SAT {
  int score = 0;

  K_SAT();
}

class Point {
  int score = 0;

  Point();
}
