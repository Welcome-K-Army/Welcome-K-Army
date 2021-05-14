enum AdmissionType {
  principal,
  aptitude,
  comprehensive,
  merit,
  village,
  needy,
  foreigner
}

class AnalysisData {
  AdmissionType type;

  /*
  FirstExam firstExam;
  Body body;
  Interview interview;
  Health health;
  Grade grade;
  K_SAT k_SAT;
  Point point;
  */

  AnalysisData({this.type});
}

/*
class FirstExam {
  
  bool pass = false;
  int max = 300;
  int current = 0;

  FirstExam();
  FirstExam({this.max});
}

class Body {
  bool pass = false;
  
  Body();
}

class Interview {
  int max = 500;
  int current = 0;

  Interview();
  Interview({this.max});
}

class Health {
  int max = 100;
  int current = 0;

  Health();
  Health({this.max});
}

class Grade {
  int max = 100;
  int current = 0;

  Grade();
  Grade({this.max});
}

class K_SAT {
  int max = 0;
  int current = 0;

  K_SAT();
  K_SAT({this.max});
}

class Point {
  int current = 0;
}

*/