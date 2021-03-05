enum NetworkException { NoInternet, NoServiceFound, InvalidFormat, Timeout, Unknown, TokenDie, NO }

class NetworkResponse<T> {
  bool isSuccess;
  int statusCode;
  T body;
  NetworkException networkEXC;
  String message;
  NetworkResponse({this.isSuccess = false, this.statusCode, this.body, this.networkEXC = NetworkException.NO, this.message});
}
