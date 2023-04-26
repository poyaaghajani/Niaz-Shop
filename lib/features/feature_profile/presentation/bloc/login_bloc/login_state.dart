import 'package:niaz_shopping/features/feature_profile/presentation/bloc/login_bloc/login_data_status.dart';

class LoginState {
  LoginDataStatus loginDataStatus;

  LoginState({
    required this.loginDataStatus,
  });

  LoginState copyWith({
    LoginDataStatus? newLoginDataStatus,
  }) {
    return LoginState(
      loginDataStatus: newLoginDataStatus ?? loginDataStatus,
    );
  }
}
