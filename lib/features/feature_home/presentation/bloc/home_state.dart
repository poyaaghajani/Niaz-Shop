import 'package:niaz_shopping/features/feature_home/presentation/bloc/home_data_status.dart';

class HomeState {
  HomeDataStatus homeDataStatus;

  HomeState({
    required this.homeDataStatus,
  });

  HomeState copyWith({
    HomeDataStatus? newHomeDataStatus,
  }) {
    return HomeState(
      homeDataStatus: newHomeDataStatus ?? homeDataStatus,
    );
  }
}
