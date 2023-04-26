import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBoxCubit extends Cubit<bool> {
  SearchBoxCubit() : super(true);

  void changeVisibility(newValue) {
    emit(newValue);
  }
}
