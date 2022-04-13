import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/bloc/category/category_bloc.dart';
import 'package:flutter_e_commerce_app/themes/constants.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';
import 'package:flutter_e_commerce_app/themes/theme.dart';
import 'package:flutter_e_commerce_app/views/widgets/product_card.dart';
import 'package:flutter_e_commerce_app/views/widgets/title_text.dart';
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
          _search(context),
          //buildFilter(context),
          // const SizedBox(height: 16),
          // _category(),
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

  Container _search(BuildContext context) {
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
              onPressed: () {
                _showFilter(context);
              },
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

void _showFilter(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    // isScrollControlled: true, // set this to true
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.9,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultRadius),
                topRight: Radius.circular(kDefaultRadius),
              ),
              color: LightColor.bgColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const TitleText(
                        text: 'Clear',
                        color: LightColor.kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TitleText(
                      text: 'Filters',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const TitleText(
                        text: 'Cancel',
                        color: LightColor.kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  //color: Colors.black,
                ),
                const SizedBox(
                  height: kDefaultPadding / 2,
                ),
                const TitleText(
                  text: 'Category',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: kDefaultPadding),
                SizedBox(
                  width: AppTheme.fullWidth(context),
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        height: 20,
                        //width: 200,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const TitleText(
                            text: 'New Products',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: LightColor.kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      SizedBox(
                        height: 20,
                        //width: 200,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const TitleText(
                            text: 'Popular Products',
                            color: LightColor.titleTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: LightColor.kPrimaryLightColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      SizedBox(
                        height: 20,
                        //width: 200,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const TitleText(
                            text: 'Trending Products',
                            color: LightColor.titleTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: LightColor.kPrimaryLightColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
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
