import 'package:niaz_shopping/features/feature_product/data/models/all_product_model.dart';

abstract class ProductsDataStatus {}

class ProductsDataLoadingStatus extends ProductsDataStatus {}

class ProductsDataCompletedStatus extends ProductsDataStatus {
  final AllProductsModel allProductsModel;

  ProductsDataCompletedStatus(this.allProductsModel);
}

class ProductsDataErrorStatus extends ProductsDataStatus {
  final String errorMessaage;

  ProductsDataErrorStatus(this.errorMessaage);
}
