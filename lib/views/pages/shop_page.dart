import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/bloc/category/category_bloc.dart';
import 'package:flutter_e_commerce_app/themes/constants.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';
import 'package:flutter_e_commerce_app/views/widgets/product_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/product/product_bloc.dart';
import '../../models/category_model.dart';
import '../../themes/light_color.dart';
import '../widgets/listview_products.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _search(),
          const SizedBox(height: 16),
          _category(),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            //padding: const EdgeInsets.all(kDefaultPadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kDefaultRadius / 2),
              child: Image.network(
                'https://i.imgur.com/4hwmteh.jpeg',
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _popularProducts(),
          const SizedBox(
            height: 16,
          ),
          _recommendProducts(),
          const SizedBox(
            height: 16,
          ),
          _newProducts(),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  _recommendProducts() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductLoaded) {
          return ListViewProducts(
            products: state.products
                .where((product) => product.isRecommended == true)
                .toList(),
            title: 'Recommended',
            press: () {},
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }

  _newProducts() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductLoaded) {
          return ListViewProducts(
            products: state.products
                .where((product) => product.isPopular == true)
                .toList(),
            title: 'New Product',
            press: () {},
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }

  _popularProducts() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductLoaded) {
          return ListViewProducts(
            products: state.products
                .where((product) => product.isPopular == true)
                .toList(),
            title: 'Popular',
            press: () {},
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }

  Container _search() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      //padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        color: LightColor.kPrimaryLightColor,
        borderRadius: BorderRadius.circular(kDefaultRadius / 1.3),
      ),
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        cursorColor: LightColor.kPrimaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          contentPadding: const EdgeInsets.only(bottom: 0, top: 10, right: 10),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: SizedBox(
            width: 45,
            // height: 10,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: LightColor.kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(kDefaultRadius / 1.5))),
              child: SvgPicture.asset(
                'assets/icons/Filter.svg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _category() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
    child: BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: Text('Categories Loading...'),
          );
        }
        if (state is CategoryLoaded) {
          return SizedBox(
            //color: kPrimaryLightColor,
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: state.categories
                  .map((category) => GestureDetector(
                        child: Container(
                          margin:
                              const EdgeInsets.only(right: kDefaultPadding / 2),
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(kDefaultRadius / 2),
                            // shape: BoxShape.rectangle,
                            //color: kPrimaryColor,
                            border: Border.all(
                                width: 1.5, color: LightColor.kPrimaryColor),
                          ),
                          child: Center(
                              child: Text(
                            category.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          )),
                        ),
                      ))
                  .toList(),
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    ),
  );
}
