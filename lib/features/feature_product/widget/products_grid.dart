import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/arguments/one_product_argument.dart';
import 'package:niaz_shopping/common/widgets/custom_buton.dart';
import 'package:niaz_shopping/common/widgets/drop_loading.dart';
import 'package:niaz_shopping/common/widgets/cached_image.dart';
import 'package:niaz_shopping/common/widgets/dot_loading.dart';
import 'package:niaz_shopping/common/widgets/product_item.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/features/feature_product/data/models/all_product_model.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/products_bloc/products_data_status.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/products_bloc/products_event.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/products_bloc/products_state.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:niaz_shopping/features/feature_product/presentation/screens/product_screen.dart';
import '../../../../common/params/products_params.dart';

class ProductsGrid extends StatelessWidget {
  final int? categoryId;
  final int? sellerId;
  final String? searchText;
  ProductsGrid({
    Key? key,
    this.categoryId,
    this.sellerId,
    this.searchText,
  }) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    // get device size
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    /// call api for data
    BlocProvider.of<ProductsBloc>(context).add(
      ProductsRequest(
        ProductsParams(
          categories: categoryId,
          search: searchText ?? '',
        ),
      ),
    );

    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state.productsDataStatus is ProductsDataLoadingStatus) {
          return const Center(
            child: Center(
              child: DotLOading(),
            ),
          );
        }

        if (state.productsDataStatus is ProductsDataCompletedStatus) {
          // ProductsDataCompletedStatus productsDataCompletedStatus =
          //     state.productsDataStatus as ProductsDataCompletedStatus;
          // AllProductsModel allProductsModel =
          //     productsDataCompletedStatus.allProductsModel;

          List<Products> allProducts = state.allProducts;

          return RefreshIndicator(
            color: CustomColors.dark,
            onRefresh: () async {
              // BlocProvider.of<AllProductsCubit>(context).add(ResetNextStartEvent());
              BlocProvider.of<ProductsBloc>(context).add(ProductsRequest(
                ProductsParams(
                  categories: categoryId,
                  search: searchText ?? '',
                ),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(height: height / 80),

                  /// filter btn
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width, height / 13),
                      backgroundColor: Colors.white,
                      elevation: 3,
                      shadowColor: CustomColors.lightAmber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // showFilterBottomSheet(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'فیلتر',
                          style: CustomTextStyle.darkMedium,
                        ),
                        Icon(
                          Icons.filter_list_alt,
                          color: CustomColors.dark,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height / 50),

                  /// all product gridview or no products for show
                  (allProducts.isNotEmpty)
                      ? Expanded(
                          child: GridView.builder(
                            controller: scrollController,
                            itemCount: allProducts.length,
                            // itemCount: allProductsModel.data![0].products!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.65,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final id = allProducts[index].id;
                              final productImage = allProducts[index].image;
                              final productName = allProducts[index].name;

                              final productDiscount =
                                  allProducts[index].discount;
                              final productPrice = allProducts[index].price;
                              final productPriceBeforeDiscount =
                                  allProducts[index].priceBeforDiscount;
                              final star = allProducts[index].star;

                              return GestureDetector(
                                onTap: () {
                                  /// goto All products screen
                                  // Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: ProductDetailArguments(allProducts[index].id!),);
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ProductScreen.routeName,
                                      arguments: OneProductArgument(
                                        id: id,
                                        image: productImage,
                                        name: productName,
                                        price: productPrice,
                                        priceBeforDiscount:
                                            productPriceBeforeDiscount,
                                        discount: productDiscount,
                                        star: star,
                                      ),
                                    );
                                  },
                                  child: ProductItem(
                                    topText: '',
                                    margin: 2,
                                    name: productName,
                                    discount: productDiscount,
                                    price: productPrice,
                                    priceBeforDiscount:
                                        productPriceBeforeDiscount,
                                    star: star,
                                    image: CachedImage(
                                      radius: 12,
                                      imageUrl: productImage,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Expanded(
                          child: Center(
                            child: Text(
                              'محصولی برای نمایش وجود ندارد',
                              style: CustomTextStyle.darkMedium,
                            ),
                          ),
                        ),

                  /// paging loading
                  (state.isLoadingPaging)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: DelayedWidget(
                            delayDuration: const Duration(milliseconds: 100),
                            animationDuration:
                                const Duration(milliseconds: 500),
                            animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                            child: const DropLoading(),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        }

        if (state.productsDataStatus is ProductsDataErrorStatus) {
          final ProductsDataErrorStatus productsDataErrorStatus =
              state.productsDataStatus as ProductsDataErrorStatus;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productsDataErrorStatus.errorMessaage,
                  style: CustomTextStyle.darkSmall,
                ),
                SizedBox(height: height / 50),
                CustomButton(
                  onPressed: () {
                    BlocProvider.of<ProductsBloc>(context).add(
                      ProductsRequest(
                        ProductsParams(
                          categories: categoryId,
                          search: searchText ?? '',
                        ),
                      ),
                    );
                  },
                  text: 'تلاش دوباره',
                  textStyle: CustomTextStyle.whiteSmall,
                  color: CustomColors.lightAmber,
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  void setupScrollController(BuildContext context) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            BlocProvider.of<ProductsBloc>(context).add(
              ProductsRequest(
                ProductsParams(
                  categories: categoryId,
                  search: searchText ?? '',
                ),
              ),
            );
          }
        }
      },
    );
  }

  // void showFilterBottomSheet(ct) {
  //   showModalBottomSheet(
  //       context: ct,
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
  //       ),
  //       builder: (context){
  //         return BlocProvider.value(
  //           value: BlocProvider.of<FilterCubit>(ct),
  //           child: BlocProvider.value(
  //                       value: BlocProvider.of<ProductsBloc>(ct),
  //                       child: FilterBottomSheet(categoryId: categoryId,)),
  //         );
  //   });
  // }
}
