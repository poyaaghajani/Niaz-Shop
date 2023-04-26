abstract class LoginEvent {}

class LoginRequest extends LoginEvent {
  String identity;
  String password;

  LoginRequest({
    required this.identity,
    required this.password,
  });
}
