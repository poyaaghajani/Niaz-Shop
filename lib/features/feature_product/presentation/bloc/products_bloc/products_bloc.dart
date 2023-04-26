import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/resources/data_state.dart';
import 'package:niaz_shopping/features/feature_product/data/models/all_product_model.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/products_bloc/products_data_status.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/products_bloc/products_event.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/products_bloc/products_state.dart';
import 'package:niaz_shopping/features/feature_product/repositories/products_repository.dart';
import 'package:niaz_shopping/locator.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsRepository repository = locator.get();

  ProductsBloc()
      : super(ProductsState(
          productsDataStatus: ProductsDataLoadingStatus(),
          allProducts: [],
          nextStart: 0,
          isLoadingPaging: false,
        )) {
    on<ProductsRequest>(
      (event, emit) async {
        if (state.nextStart == 0) {
          emit(state.copyWith(
              newProductsDataStatus: ProductsDataLoadingStatus()));
        } else {
          emit(state.copyWith(newIsLoadingPaging: true));
        }

        // change nextStart before call API
        event.productsParams.start = state.nextStart;
        DataState dataState =
            await repository.fetchAllProductsData(event.productsParams);

        // emit completed
        if (dataState is DataSuccess) {
          AllProductsModel allProductsModel = dataState.data;

          emit(state.copyWith(
            newProductsDataStatus:
                ProductsDataCompletedStatus(allProductsModel),
            newAllProducts: state.allProducts
              ..addAll(allProductsModel.data![0].products!),
            newNextStart: allProductsModel.data![0].nextStart,
            newIsLoadingPaging: false,
          ));
        }

        // emit error
        if (dataState is DataFailed) {
          emit(state.copyWith(
            newProductsDataStatus: ProductsDataErrorStatus(dataState.error!),
            newIsLoadingPaging: false,
          ));
        }
      },
    );
  }
}
