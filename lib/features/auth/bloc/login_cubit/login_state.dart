part of 'login_cubit.dart';

class LoginInitial {
  final CubitStatuses statuses;
  final LoginResult result;
  final String error;
  final LoginRequest request;

  const LoginInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory LoginInitial.initial() {
    return LoginInitial(
      result: LoginResult.fromJson({}),
      error: '',
      request: LoginRequest.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  LoginInitial copyWith({
    CubitStatuses? statuses,
    LoginResult? result,
    String? error,
    LoginRequest? request,
  }) {
    return LoginInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
