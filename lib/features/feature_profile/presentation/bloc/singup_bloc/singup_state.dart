import 'package:niaz_shopping/features/feature_profile/presentation/bloc/singup_bloc/singup_data_status.dart';

class SingupState {
  SingupDataStatus singupDataStatus;

  SingupState({
    required this.singupDataStatus,
  });

  SingupState copyWith({
    SingupDataStatus? newSingupDataStatus,
  }) {
    return SingupState(
      singupDataStatus: newSingupDataStatus ?? singupDataStatus,
    );
  }
}
