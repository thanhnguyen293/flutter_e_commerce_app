import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/models/cart_model.dart';
import 'package:flutter_e_commerce_app/themes/constants.dart';
import 'package:flutter_e_commerce_app/themes/light_color.dart';
import 'package:flutter_e_commerce_app/views/widgets/title_text.dart';

import '../../bloc/cart/cart_bloc.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    Key? key,
    required this.cartItem,
    required this.quantity,
  }) : super(key: key);

  final CartItem cartItem;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const ValueKey(1),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => _showAlertDialog(context),
        );
      },
      background: Container(
        color: LightColor.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: kDefaultPadding),
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _productImage(),
                const SizedBox(width: 10),
                _title(),
                const SizedBox(width: kDefaultPadding / 2),
                _quantity(),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            const Divider(
              color: LightColor.grey,
              height: 0,
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog _showAlertDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius / 2)),
      title: const TitleText(
        text: 'Remove from cart!',
        fontWeight: FontWeight.w800,
      ),
      content: const TitleText(
        text: 'Do you want to remove the product from the cart?',
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const TitleText(
            text: 'Cancel',
            fontWeight: FontWeight.w600,
            color: LightColor.skyBlue,
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<CartBloc>().add(CartProductRemoved(cartItem));
            Navigator.of(context).pop(false);
          },
          child: const TitleText(
            text: 'Accept',
            fontWeight: FontWeight.w600,
            color: LightColor.skyBlue,
          ),
        ),
      ],
    );
  }

  Expanded _title() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            text: cartItem.product.title,
            fontSize: 15,
            //fontWeight: FontWeight.w700,
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          Row(
            children: [
              const TitleText(
                text: 'Size: ',
                color: LightColor.red,
                fontSize: 14,
              ),
              TitleText(
                text: cartItem.size.toString() + ' (US)',
                fontSize: 14,
                //fontWeight: FontWeight.w800,
              ),
            ],
          ),

          // Row(
          //   children: const [
          //     TitleText(
          //       text: 'Color: ',
          //       fontSize: 14,
          //       color: LightColor.red,
          //     ),
          //     TitleText(
          //       text: 'Red',
          //       fontSize: 14,
          //       //fontWeight: FontWeight.w700,
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          Row(
            children: [
              const TitleText(
                text: 'Price: ',
                color: LightColor.red,
                fontSize: 14,
              ),
              TitleText(
                text: cartItem.product.price.toString(),
                fontSize: 14,
                //style: Theme.of(context).textTheme.headline6,
              ),
              const TitleText(
                text: '\$ ',
                color: LightColor.red,
                fontSize: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }

  BlocBuilder<CartBloc, CartState> _quantity() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  context.read<CartBloc>().add(
                        CartProductAdded(cartItem),
                      );
                },
                child: const Icon(Icons.arrow_drop_up),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: LightColor.kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(kDefaultRadius / 3)),
                child: Center(
                  child: TitleText(
                    text: 'x' + quantity.toString(),
                    fontSize: 14,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<CartBloc>().add(
                        CartSingleProductRemoved(cartItem),
                      );
                },
                child: const Icon(Icons.arrow_drop_down),
              )
            ],
          );
        }
        return const Text('Something went wrong!');
      },
    );
  }

  Container _productImage() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: LightColor.kPrimaryLightColor,
          borderRadius: BorderRadius.circular(kDefaultRadius / 2)),
      child: Image.network(
        cartItem.product.imageUrl.first,
        fit: BoxFit.fitWidth,
        width: 100,
        height: 80,
      ),
    );
  }
}
