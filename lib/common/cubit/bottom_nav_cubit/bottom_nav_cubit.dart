import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  // just emit user is in which index
  changeSelectedIndex(newIndex) {
    emit(newIndex);
  }
}
