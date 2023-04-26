import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:niaz_shopping/common/arguments/products_argument.dart';
import 'package:niaz_shopping/common/cubit/search_box_cubit/search_box_cubit.dart';
import 'package:niaz_shopping/common/params/products_params.dart';
import 'package:niaz_shopping/common/widgets/drop_loading.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/features/feature_product/data/models/all_product_model.dart';
import 'package:niaz_shopping/features/feature_product/presentation/screens/all_products_screen.dart';
import 'package:niaz_shopping/features/feature_product/repositories/products_repository.dart';
import 'package:niaz_shopping/locator.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ProductsRepository productRepository = locator.get();

  SearchTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        /// textfield
        SizedBox(
          height: 40,
          child: TypeAheadField(
            loadingBuilder: (context) {
              return const Center(
                child: DropLoading(),
              );
            },
            noItemsFoundBuilder: (context) {
              return const ListTile(
                title: Text("محصولی یافت نشد.!"),
                titleTextStyle: CustomTextStyle.darkMedium,
              );
            },
            textFieldConfiguration: TextFieldConfiguration(
              onSubmitted: (String prefix) {
                if (controller.text.isEmpty) {
                  BlocProvider.of<SearchBoxCubit>(context)
                      .changeVisibility(true);
                } else {
                  BlocProvider.of<SearchBoxCubit>(context)
                      .changeVisibility(false);
                  Navigator.pushNamed(
                    context,
                    AllProductsScreen.routeName,
                    arguments: ProductsArguments(searchTxt: prefix),
                  );
                }
              },
              onTap: () {
                BlocProvider.of<SearchBoxCubit>(context)
                    .changeVisibility(false);
              },
              controller: controller,
              style: CustomTextStyle.darkMedium,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                contentPadding: const EdgeInsets.all(3),
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AllProductsScreen.routeName,
                      arguments: ProductsArguments(searchTxt: controller.text),
                    );
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: CustomColors.grey,
                    width: 0.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: CustomColors.grey,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            suggestionsCallback: (String prefix) {
              return productRepository.fetchAllProductsSearch(
                  ProductsParams(step: 6, search: prefix));
            },
            itemBuilder: (context, Products model) {
              return ListTile(
                title: Text(
                  model.name!,
                  style: CustomTextStyle.darkMedium,
                ),
              );
            },
            onSuggestionSelected: (Products products) {
              controller.text = products.name!;
              Navigator.pushNamed(
                context,
                AllProductsScreen.routeName,
                arguments: ProductsArguments(searchTxt: products.name!),
              );
            },
          ),
        ),

        /// text and logo
        IgnorePointer(
          child: BlocBuilder<SearchBoxCubit, bool>(
            builder: (context, state) {
              return Visibility(
                visible: state,
                child: Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Row(
                    children: [
                      const Text(
                        'جستوجو در',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(width: width / 8),
                      const Text(
                        'نیاز',
                        style: TextStyle(
                          fontFamily: 'mr',
                          color: CustomColors.lightAmber,
                        ),
                      ),
                      const Text(
                        'شاپ',
                        style: TextStyle(fontFamily: 'mr'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
