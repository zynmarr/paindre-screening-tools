class Handler implements Exception {
  final int statusCode;
  final String message;
  final dynamic prefix;
  Handler(
    this.statusCode,
    this.message,
    this.prefix,
  );

  @override
  String toString() => 'Handler(status code:$statusCode, message: $message, prefix: $prefix)';

  List<Object> get props => [statusCode, message, prefix];
}

class FetchDataException extends Handler {
  FetchDataException(int statusCode, String message) : super(statusCode, message, 'Error During Communication');
}

class BadRequestException extends Handler {
  BadRequestException(int statusCode, String message) : super(statusCode, message, 'Invalid request');
}

class UnauthorizedException extends Handler {
  UnauthorizedException(int statusCode, String message) : super(statusCode, message, 'Unauthorized request');
}
