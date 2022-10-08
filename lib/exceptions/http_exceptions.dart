class HttpExceptions implements Exception {
  final String? mg;
  final int? statsCode;
  HttpExceptions({this.mg, this.statsCode});

  @override
  String toString() {
    return mg!;
  }
}
