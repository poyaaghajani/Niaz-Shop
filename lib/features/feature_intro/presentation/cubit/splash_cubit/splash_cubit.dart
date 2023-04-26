import 'package:bloc/bloc.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/cubit/splash_cubit/connection_status.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/cubit/splash_cubit/splash_state.dart';
import 'package:niaz_shopping/features/feature_intro/repository/splash_repository.dart';
import 'package:niaz_shopping/locator.dart';

class SplashCubit extends Cubit<SplashState> {
  ISplashRepository splashRepository = locator.get();

  SplashCubit()
      : super(SplashState(
          connectionStatus: ConnectionInit(),
        ));

  void checkConnectionState() async {
    emit(state.copyWith(newConnectionStatus: ConnectionInit()));

    // this variable check connection in ON or OFF
    bool isConnect = await splashRepository.checkConnectivity();

    // if isConnect => ConnectionON
    // if !isConnect => ConnectionOFF
    if (isConnect) {
      emit(state.copyWith(newConnectionStatus: ConnectionON()));
    } else {
      emit(state.copyWith(newConnectionStatus: ConnectionOFF()));
    }
  }
}
