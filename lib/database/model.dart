library analytics.orm;

abstract class Model {
  String table() {
    return (this).toString().split('\'')[1];
  }
}

class AnalysisFile extends Model {
  String testvar;
  String testvar2 = 'woot';
}
