enum ApiStatus {
  success,
  error,
}

class ApiState<T> {

  final ApiStatus status;

  final T? data;

  final String? message;

  ApiState({

    required this.status,

    this.data,

    this.message,
  });

  factory ApiState.success(

    T data,

  ) {

    return ApiState(

      status:
          ApiStatus.success,

      data: data,
    );
  }

  factory ApiState.error(

    String message,

  ) {

    return ApiState(

      status:
          ApiStatus.error,

      message: message,
    );
  }
}