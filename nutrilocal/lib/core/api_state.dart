enum ApiStatus {

  initial,

  loading,

  success,

  error,
}

class ApiState<T> {

  final ApiStatus status;

  final T? data;

  final String? message;

  const ApiState({

    required this.status,

    this.data,

    this.message,
  });

  factory ApiState.initial() {

    return const ApiState(
      status: ApiStatus.initial,
    );
  }

  factory ApiState.loading() {

    return const ApiState(
      status: ApiStatus.loading,
    );
  }

  factory ApiState.success(
    T data,
  ) {

    return ApiState(

      status: ApiStatus.success,

      data: data,
    );
  }

  factory ApiState.error(
    String message,
  ) {

    return ApiState(

      status: ApiStatus.error,

      message: message,
    );
  }
}