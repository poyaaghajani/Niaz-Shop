import 'package:niaz_shopping/features/feature_product/data/models/category_model.dart';

abstract class CategoryDataStatus {}

class CategoryLoadingStatus extends CategoryDataStatus {}

class CategoryCompletedStatus extends CategoryDataStatus {
  final CategoryModel categoryModel;

  CategoryCompletedStatus(this.categoryModel);
}

class CategoryErrorStatus extends CategoryDataStatus {
  final String errorMessage;

  CategoryErrorStatus(this.errorMessage);
}
