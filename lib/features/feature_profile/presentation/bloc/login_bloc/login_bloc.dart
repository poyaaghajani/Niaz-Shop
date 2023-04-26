import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/login_bloc/login_data_status.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/login_bloc/login_event.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/login_bloc/login_state.dart';
import 'package:niaz_shopping/features/feature_profile/repositories/login_repository.dart';
import 'package:niaz_shopping/locator.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository repository = locator.get();

  LoginBloc() : super(LoginState(loginDataStatus: LoginDataInitStatus())) {
    on<LoginRequest>(
      (event, emit) async {
        emit(state.copyWith(newLoginDataStatus: LoginDataLoadingStatus()));

        var response = await repository.fetchLogin(
          event.identity,
          event.password,
        );

        if (PrefsManager.readToken().isNotEmpty) {
          emit(state.copyWith(
              newLoginDataStatus: LoginDataCompletedStatus(response)));
        }
        if (PrefsManager.readToken().isEmpty) {
          emit(state.copyWith(
              newLoginDataStatus: LoginDataErrorStatus(response)));
        }
      },
    );
  }
}
