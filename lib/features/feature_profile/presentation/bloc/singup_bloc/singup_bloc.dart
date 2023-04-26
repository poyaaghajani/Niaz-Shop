import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/singup_bloc/singup_data_status.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/singup_bloc/singup_event.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/singup_bloc/singup_state.dart';
import 'package:niaz_shopping/features/feature_profile/repositories/singup_repository.dart';
import 'package:niaz_shopping/locator.dart';

class SingupBloc extends Bloc<SingupEvent, SingupState> {
  SingupRepository repository = locator.get();

  SingupBloc() : super(SingupState(singupDataStatus: SingupDataInitStatus())) {
    on<SingupRequest>(
      (event, emit) async {
        emit(state.copyWith(newSingupDataStatus: SingupDataLoadingStatus()));

        var response = await repository.fetchSingup(
          event.username,
          event.password,
          event.passwordConfirm,
        );

        if (PrefsManager.readId().isNotEmpty) {
          emit(state.copyWith(
              newSingupDataStatus: SingupDataCompletedStatus(response)));
        }
        if (PrefsManager.readId().isEmpty) {
          emit(state.copyWith(
              newSingupDataStatus: SingupDataErrorStatus(response)));
        }
      },
    );
  }
}
