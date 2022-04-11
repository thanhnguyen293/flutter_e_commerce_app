import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/themes/constants.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../themes/light_color.dart';
import '../../themes/theme.dart';
import '../widgets/cart_product_card.dart';
import '../widgets/title_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBar(title: 'Cart'),
      //bottomNavigationBar: CustomNavBar(screen: routeName),
      body: Column(
        children: [
          _title(),
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is CartLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       state.cart.freeDeliveryString,
                        //       //style: Theme.of(context).textTheme.headline5,
                        //     ),
                        //     ElevatedButton(
                        //       onPressed: () {
                        //         Navigator.pushNamed(context, '/');
                        //       },
                        //       style: ElevatedButton.styleFrom(
                        //         primary: Colors.black,
                        //         shape: const RoundedRectangleBorder(),
                        //         elevation: 0,
                        //       ),
                        //       child: const Text(
                        //         'Add More Items',
                        //         // style: Theme.of(context)
                        //         //     .textTheme
                        //         //     .headline5!
                        //         //     .copyWith(color: Colors.white),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        //Checkbox(value: value, onChanged: onChanged)

                        state.cart.cartItems.isEmpty
                            ? const Expanded(
                                child: Center(
                                  child: TitleText(
                                    text: 'No orders yet',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  children: [
                                    //const SizedBox(height: kDefaultPadding),
                                    _cartItems(state),
                                  ],
                                ),
                              ),

                        const Divider(
                          thickness: 1.5,
                        ),
                        const SizedBox(height: kDefaultPadding / 2),
                        _price(state),
                        const SizedBox(height: kDefaultPadding),
                        _submitButton(context),
                        //OrderSummary(),
                      ],
                    ),
                  );
                }
                return const Text('Something went wrong');
              },
            ),
          ),
        ],
      ),
    );
  }

  TextButton _submitButton(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultRadius / 2)),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>(LightColor.kPrimaryColor),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4),
        width: AppTheme.fullWidth(context) * .75,
        child: const TitleText(
          text: 'Next',
          color: LightColor.bgColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _price(CartLoaded state) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleText(
              text: 'Total Amount(' + state.cart.subItem.toString() + ' Items)',
              fontWeight: FontWeight.w600,
            ),
            TitleText(
              text: '\$' + state.cart.subtotalString,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(
          height: kDefaultPadding / 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleText(
              text: 'Delivery Fee',
              fontWeight: FontWeight.w600,
            ),
            TitleText(
              text: '\$' + state.cart.deliveryFeeString,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(
          height: kDefaultPadding / 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleText(text: 'Total Payment'),
            TitleText(
              text: '\$' + state.cart.totalString,
              fontSize: 18,
            ),
          ],
        ),
      ],
    );
  }

  Expanded _cartItems(CartLoaded state) {
    return Expanded(
      child: ListView.builder(
          itemCount: state.cart.cartItems.length,
          itemBuilder: (BuildContext context, int index) {
            return CartProductCard(
              cartItem: state.cart.cartItems.keys.elementAt(index),
              quantity: state.cart.cartItems.values.elementAt(index),
            );
          }),
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
                  text: 'Shopping',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text: 'Cart',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.delete_outline,
                  color: LightColor.kPrimaryColor,
                ),
              ),
            )
          ],
        ));
  }
}
