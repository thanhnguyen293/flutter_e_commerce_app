import 'package:flutter/material.dart';

import '../../themes/constants.dart';
import '../../models/product_model.dart';
import '../../views/pages/product_detail_page.dart';
import '../../views/widgets/title_text.dart';
import '../../themes/light_color.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailPage.routeName, arguments: product);
      },
      child: Container(
        width: 165,
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        decoration: BoxDecoration(
            color: LightColor.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(kDefaultRadius / 2)),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  product.imageUrl[0],
                  height: 150,
                  //fit: box,
                ),
              ),
            ),
            TitleText(
              text: product.title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              maxLines: 2,
            ),
            Row(
              children: [
                const TitleText(
                  text: '\$',
                  color: LightColor.kPrimaryColor,
                  fontSize: 16,
                ),
                const SizedBox(
                  width: 3,
                ),
                TitleText(
                  text: product.price.round().toString(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
