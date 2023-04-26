abstract class SingupEvent {}

class SingupRequest extends SingupEvent {
  String username;
  String password;
  String passwordConfirm;

  SingupRequest(
    this.username,
    this.password,
    this.passwordConfirm,
  );
}
