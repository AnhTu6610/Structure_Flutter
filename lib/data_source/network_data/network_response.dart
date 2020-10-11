enum NetworkException {
  NoInternet,
  NoServiceFound,
  InvalidFormat,
  Unknown,
  TokenDie,
  NO
}

class NetworkResponse<T> {
  bool isSuccess;
  int statusCode;
  T body;
  NetworkException networkEXC;
  NetworkResponse({
    this.isSuccess = false,
    this.statusCode,
    this.body,
    this.networkEXC = NetworkException.NO,
  });
}
