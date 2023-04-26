import 'package:niaz_shopping/features/feature_product/presentation/bloc/category_bloc/category_data_status.dart';

class CategoryState {
  CategoryDataStatus categoryDataStatus;

  CategoryState({required this.categoryDataStatus});

  CategoryState copyWith({
    CategoryDataStatus? newCategoryDataStatus,
  }) {
    return CategoryState(
      categoryDataStatus: newCategoryDataStatus ?? categoryDataStatus,
    );
  }
}
