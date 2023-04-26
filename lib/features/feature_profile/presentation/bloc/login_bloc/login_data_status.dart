abstract class LoginDataStatus {}

class LoginDataInitStatus extends LoginDataStatus {}

class LoginDataLoadingStatus extends LoginDataStatus {}

class LoginDataCompletedStatus extends LoginDataStatus {
  final String response;
  LoginDataCompletedStatus(this.response);
}

class LoginDataErrorStatus extends LoginDataStatus {
  final String errorMessage;
  LoginDataErrorStatus(this.errorMessage);
}
