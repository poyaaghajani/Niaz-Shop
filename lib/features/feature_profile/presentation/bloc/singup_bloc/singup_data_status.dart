abstract class SingupDataStatus {}

class SingupDataInitStatus extends SingupDataStatus {}

class SingupDataLoadingStatus extends SingupDataStatus {}

class SingupDataCompletedStatus extends SingupDataStatus {
  final String response;

  SingupDataCompletedStatus(this.response);
}

class SingupDataErrorStatus extends SingupDataStatus {
  final String errorMessage;

  SingupDataErrorStatus(this.errorMessage);
}
