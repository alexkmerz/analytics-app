class FF {
  final String path;
  final String status;

  FF(this.path, this.status);

  String toSQL() {
    return 'INSERT INTO files(path, status) VALUES(?, ?)';
  }

  List<dynamic> params() {
    return [this.path, this.status];
  }
}
