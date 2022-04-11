import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/views/widgets/title_text.dart';

import '../../themes/constants.dart';
import '../../models/product_model.dart';
import '../../themes/light_color.dart';
import 'product_card.dart';

class ListViewProducts extends StatelessWidget {
  final List<Product> products;
  final String title;
  final VoidCallback press;
  const ListViewProducts({
    required this.products,
    required this.title,
    required this.press,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: kDefaultPadding, right: kDefaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  text: title,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                TextButton(
                  onPressed: press,
                  child: const TitleText(
                    text: 'See All',
                    color: LightColor.titleTextColor,
                    fontSize: 16,
                  ),
                  style: TextButton.styleFrom(
                    // textStyle: const TextStyle(
                    //   fontWeight: FontWeight.w700,
                    // ),
                    // backgroundColor: LightColor.kPrimaryColor,
                    padding: const EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 240, //MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    const SizedBox(
                      width: kDefaultPadding,
                    ),
                    ProductCard(product: products[index]),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
