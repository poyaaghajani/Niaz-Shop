import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/resources/data_state.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/category_bloc/category_data_status.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/category_bloc/category_event.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/category_bloc/category_state.dart';
import 'package:niaz_shopping/features/feature_product/repositories/category_repository.dart';
import 'package:niaz_shopping/locator.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository repository = locator.get();

  CategoryBloc()
      : super(CategoryState(
          categoryDataStatus: CategoryLoadingStatus(),
        )) {
    on<CategoryRequest>(
      (event, emit) async {
        emit(state.copyWith(newCategoryDataStatus: CategoryLoadingStatus()));

        DataState dataState = await repository.fetchCategoryData();

        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newCategoryDataStatus: CategoryCompletedStatus(dataState.data)));
        }
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newCategoryDataStatus:
                  CategoryErrorStatus(dataState.error ?? 'unknown error')));
        }
      },
    );
  }
}
