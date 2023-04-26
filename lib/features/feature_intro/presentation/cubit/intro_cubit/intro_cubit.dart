import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/cubit/intro_cubit/intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit() : super(IntroState(showGetStart: false));

  //if (value = false) => newShowGetStatrt = false
  //if (value = true) => newShowGetStatrt = true
  void changeGetStart(bool value) {
    emit(state.copyWith(newShowGetStatrt: value));
  }
}
