abstract class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);

  @override
  String toString() => message;
}

class NoInternetException extends NetworkException {
  const NoInternetException() : super('No internet connection');
}

class TimeoutException extends NetworkException {
  const TimeoutException() : super('Connection timed out');
}

class ClientException extends NetworkException {
  const ClientException(super.message);
}

class ServerException extends NetworkException {
  const ServerException() : super('Server error occurred');
}

class UnknownNetworkException extends NetworkException {
  const UnknownNetworkException()
      : super('Unexpected network error occurred');
}
