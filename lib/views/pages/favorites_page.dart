import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/themes/constants.dart';

import '../../bloc/wishlist/wishlist_bloc.dart';
import '../../themes/light_color.dart';
import '../../themes/theme.dart';
import '../widgets/product_card.dart';
import '../widgets/title_text.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const CircularProgressIndicator();
            }
            if (state is WishlistLoaded) {
              return Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: state.wishlist.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 2,
                          vertical: kDefaultPadding / 2),
                      child: ProductCard(
                        product: state.wishlist.products[index],
                      ),
                    );
                  },
                ),
              );
            }
            return const Text('Something went wrong!');
          },
        ),
      ],
    );
  }

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                TitleText(
                  text: 'Your',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text: 'Favorites',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            const Spacer(),
            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     padding: const EdgeInsets.all(10),
            //     child: const Icon(
            //       Icons.delete_outline,
            //       color: LightColor.kPrimaryColor,
            //     ),
            //   ),
            // )
          ],
        ));
  }
}

class BuildPageView extends StatelessWidget {
  const BuildPageView({
    Key? key,
    required this.pageViewController,
  }) : super(key: key);

  final PageController pageViewController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      scrollDirection: Axis.horizontal,
      children: const [
        SizedBox(
          height: 300,
          child: Center(child: Text('Image 1')),
        ),
        SizedBox(
          height: 300,
          child: Center(child: Text('Image 2')),
        ),
      ],
    );
  }
}
