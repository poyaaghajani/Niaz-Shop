import 'package:niaz_shopping/common/params/products_params.dart';

abstract class ProductsEvent {}

class ProductsRequest extends ProductsEvent {
  ProductsParams productsParams;

  ProductsRequest(this.productsParams);
}
