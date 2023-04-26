import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/resources/data_state.dart';
import 'package:niaz_shopping/features/feature_home/presentation/bloc/home_data_status.dart';
import 'package:niaz_shopping/features/feature_home/presentation/bloc/home_event.dart';
import 'package:niaz_shopping/features/feature_home/presentation/bloc/home_state.dart';
import 'package:niaz_shopping/features/feature_home/repositories/home_repository.dart';
import 'package:niaz_shopping/locator.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repository = locator.get();

  HomeBloc() : super(HomeState(homeDataStatus: HomeDataLoading())) {
    on<HomeRequest>(
      (event, emit) async {
        emit(state.copyWith(newHomeDataStatus: HomeDataLoading()));

        DataState dataState = await repository.fetchHomeData();

        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newHomeDataStatus: HomeDataCompleted(dataState.data)));
        }
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newHomeDataStatus:
                  HomeDataError(dataState.error ?? 'unknown error')));
        }
      },
    );
  }
}
