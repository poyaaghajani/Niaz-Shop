class ApiExeption implements Exception {
  int? code;
  String? message;

  ApiExeption(this.code, this.message);
}
