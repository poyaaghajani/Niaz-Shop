import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/arguments/products_argument.dart';
import 'package:niaz_shopping/common/widgets/cached_image.dart';
import 'package:niaz_shopping/common/widgets/custom_buton.dart';
import 'package:niaz_shopping/common/widgets/dot_loading.dart';
import 'package:niaz_shopping/common/widgets/search_textfield.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/features/feature_product/data/models/category_model.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/category_bloc/category_data_status.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/category_bloc/category_event.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/category_bloc/category_state.dart';
import 'package:niaz_shopping/features/feature_product/presentation/screens/all_products_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.categoryDataStatus is CategoryLoadingStatus) {
            return const Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: DotLOading(),
              ),
            );
          }
          if (state.categoryDataStatus is CategoryErrorStatus) {
            final CategoryErrorStatus categoryError =
                state.categoryDataStatus as CategoryErrorStatus;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(categoryError.errorMessage),
                  CustomButton(
                    onPressed: () {
                      BlocProvider.of<CategoryBloc>(context)
                          .add(CategoryRequest());
                    },
                    text: 'تلاش دوباره',
                    textStyle: CustomTextStyle.whiteSmall,
                    color: CustomColors.lightAmber,
                  )
                ],
              ),
            );
          }
          if (state.categoryDataStatus is CategoryCompletedStatus) {
            CategoryCompletedStatus categoryCompletedStatus =
                state.categoryDataStatus as CategoryCompletedStatus;

            CategoryModel categoryModel = categoryCompletedStatus.categoryModel;

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey.shade400,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, bottom: 10, top: 10),
                    child: SearchTextField(
                      controller: searchController,
                    ),
                  ),
                ),
                SizedBox(height: height / 70),
                (categoryModel.data!.isNotEmpty)
                    ? Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: categoryModel.data!.length,
                          padding: const EdgeInsets.only(top: 20),
                          itemBuilder: (context, index) {
                            /// text
                            return GestureDetector(
                              onTap: () {
                                // go to AllProducts screen
                                Navigator.pushNamed(
                                  context,
                                  AllProductsScreen.routeName,
                                  arguments: ProductsArguments(
                                    categoryId: categoryModel.data![index].id!,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Container(
                                  height: height / 13,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(5, 5),
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CachedImage(
                                              radius: 20,
                                              imageUrl: categoryModel
                                                  .data![index].img,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              categoryModel.data![index].title!,
                                              style: CustomTextStyle.darkMedium,
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 15,
                                          color: CustomColors.dark,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                        ),
                      )
                    : Container(),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
