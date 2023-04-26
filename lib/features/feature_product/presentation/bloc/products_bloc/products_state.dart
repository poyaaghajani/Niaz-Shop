import 'package:niaz_shopping/features/feature_product/data/models/all_product_model.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/products_bloc/products_data_status.dart';

class ProductsState {
  ProductsDataStatus productsDataStatus;
  // get all products from server, whenerer the value changes, we will show it in UI
  List<Products> allProducts;
  // get nextStatrt from server, for first time nextStart is 0, for secend time nextStart is 9, for.......
  int nextStart;
  // show a little loading end of scrren and show new products
  bool isLoadingPaging;

  ProductsState({
    required this.productsDataStatus,
    required this.allProducts,
    required this.nextStart,
    required this.isLoadingPaging,
  });

  ProductsState copyWith({
    ProductsDataStatus? newProductsDataStatus,
    List<Products>? newAllProducts,
    int? newNextStart,
    bool? newIsLoadingPaging,
  }) {
    return ProductsState(
      productsDataStatus: newProductsDataStatus ?? productsDataStatus,
      allProducts: newAllProducts ?? allProducts,
      nextStart: newNextStart ?? nextStart,
      isLoadingPaging: newIsLoadingPaging ?? isLoadingPaging,
    );
  }
}
