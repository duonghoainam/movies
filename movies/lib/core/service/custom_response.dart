sealed class AppResponse {
  AppResponse._();

  factory AppResponse.map(int code, {required Map<String, dynamic> json}) {
    return switch (code) {
      200 || 201 => SuccessResponse(json['data']),
      _ => ErrorResponse.fromCode(code)
    };
  }

  T map<T>(T Function(SuccessResponse response) success,
      T Function(ErrorResponse response) error) {
    return switch (this) {
      SuccessResponse res => success(res),
      ErrorResponse res => error(res),
    };
  }
}

sealed class ErrorResponse extends AppResponse implements Exception {
  final int code;
  final String message;

  ErrorResponse({required this.code, required this.message}) : super._();

  @override
  String toString() {
    return 'Error $code: $message';
  }

  factory ErrorResponse.fromCode(int code) {
    return switch (code) {
      401 => _UnAuthError(),
      403 => _NoPermissionError(),
      404 => _NotFoundError(),
      500 => _ServerError(),
      _ => _UnknownError(),
    };
  }

}

final class _UnAuthError extends ErrorResponse {
  _UnAuthError() : super(code: 401, message: "You haven't logged in");
}

final class _NoPermissionError extends ErrorResponse {
  _NoPermissionError() : super(code: 403, message: "You don't have permission");
}

final class _NotFoundError extends ErrorResponse {
  _NotFoundError() : super(code: 404, message: "Cannot found this");
}

final class _UnknownError extends ErrorResponse {
  _UnknownError()
      : super(
            code: 0,
            message: "Can't communicate with server. Please try again");
}

final class _ServerError extends ErrorResponse {
  _ServerError() : super(code: 500, message: "Server error");
}

final class SuccessResponse extends AppResponse {
  final dynamic data;

  SuccessResponse(this.data) : super._();
}
