import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/arguments/products_argument.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:niaz_shopping/features/feature_product/widget/products_grid.dart';

class AllProductsScreen extends StatefulWidget {
  static const routeName = '/all_products_screen';

  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    /// get categoryId
    final arg = ModalRoute.of(context)!.settings.arguments as ProductsArguments;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductsBloc()),
        // BlocProvider(create: (_) =>  FilterCubit()),
      ],
      child: Scaffold(
        backgroundColor: CustomColors.backgroundScreenColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: CustomColors.lightAmber,
          title: const Text(
            'محصولات',
            style: CustomTextStyle.whiteLarge,
          ),
          centerTitle: true,
        ),
        body: ProductsGrid(
          categoryId: arg.categoryId,
          searchText: arg.searchTxt,
          sellerId: arg.sellerId,
        ),
      ),
    );
  }
}
