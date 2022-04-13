import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_e_commerce_app/bloc/wishlist/wishlist_bloc.dart';
import 'package:flutter_e_commerce_app/models/cart_model.dart';

import 'package:flutter_e_commerce_app/themes/constants.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../models/product_model.dart';
import '../../themes/light_color.dart';
import '../widgets/title_text.dart';

class ProductDetailPage extends StatefulWidget {
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ProductDetailPage(product: product),
    );
  }

  final Product product;
  const ProductDetailPage({required this.product, Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int activeIndex = 0;
  double selectedSize = 0;
  Color? selectedColor;

  final pageViewController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingButton(widget.product, selectedSize),
      body: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     Color.fromARGB(0, 193, 193, 193),
          //     Color.fromARGB(255, 142, 142, 142),
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          color: LightColor.kPrimaryLightColor,
        ),
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                children: <Widget>[
                  _appBar(context),
                  //_productImage(),
                  Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: widget.product.imageUrl.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Image.network(widget.product.imageUrl[itemIndex]),
                        //carouselController: buttonCarouselController,
                        options: CarouselOptions(
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 2.0,
                            initialPage: 0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            }),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      buildIndicator(),
                    ],
                  ),

                  // _categoryWidget(),
                ],
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: 0.57,
              minChildSize: .57,
              builder: (ctx, scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding / 2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultRadius),
                      topRight: Radius.circular(kDefaultRadius),
                    ),
                    color: LightColor.bgColor,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: const BoxDecoration(
                                color: LightColor.iconColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const SizedBox(height: 10),
                        _detailWidget(),
                        const SizedBox(height: kDefaultPadding),
                        _availableSize(),
                        const SizedBox(height: kDefaultPadding),
                        // _availableColor(),
                        // const SizedBox(height: kDefaultPadding),
                        _description(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                // border: Border.all(
                //   color: LightColor.iconColor,
                //   style: BorderStyle.solid,
                // ),
                borderRadius: BorderRadius.all(Radius.circular(13)),
                color: LightColor.bgColor,
              ),
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state is WishlistLoading) {
                return const CircularProgressIndicator();
              }
              if (state is WishlistLoaded) {
                return InkWell(
                  onTap: () {
                    if (state.wishlist.products.contains(widget.product)) {
                      context
                          .read<WishlistBloc>()
                          .add(WishlistProductRemoved(widget.product));
                    } else {
                      context
                          .read<WishlistBloc>()
                          .add(WishlistProductAdded(widget.product));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      // border: Border.all(
                      //   color: LightColor.iconColor,
                      //   style: state.wishlist.products.contains(widget.product)
                      //       ? BorderStyle.none
                      //       : BorderStyle.solid,
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Icon(
                      state.wishlist.products.contains(widget.product)
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: LightColor.red,
                    ),
                  ),
                );
              }
              return const Text('Something went wrong');
            },
          )
        ],
      ),
    );
  }

  Row _detailWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding / 4),
            child: TitleText(text: widget.product.title, fontSize: 25),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const TitleText(
                  text: "\$ ",
                  fontSize: 18,
                  color: LightColor.red,
                ),
                TitleText(
                  text: widget.product.price.toString(),
                  fontSize: 25,
                ),
              ],
            ),
            Row(
              children: const <Widget>[
                Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                Icon(Icons.star_border, size: 17),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Widget _productImage() {
  //   return CarouselSlider.builder(
  //     itemCount: widget.product.imageUrl.length,
  //     itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
  //         Image.network(widget.product.imageUrl[itemIndex]),
  //     options: CarouselOptions(
  //       autoPlayAnimationDuration: const Duration(seconds: 1),
  //       autoPlay: true,
  //       enlargeCenterPage: true,
  //       viewportFraction: 1,
  //       aspectRatio: 2.0,
  //       initialPage: 0,
  //     ),
  //   );
  //   // return SizedBox(
  //   //   height: 300,
  //   //   child: Center(child: Image.network(widget.product.imageUrl)),
  //   // );
  // }
  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
          dotHeight: 4,
          dotWidth: 20,
          spacing: 4,
          dotColor: LightColor.lightGrey,
          activeDotColor: LightColor.grey,
        ),
        activeIndex: activeIndex,
        count: widget.product.imageUrl.length,
      );

  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          text: "Available Size",
          fontSize: 14,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.product.availableSize.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding / 2),
                child: _sizeButton(
                  groupValue: selectedSize,
                  value: double.parse(widget.product.availableSize[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _sizeButton({required double groupValue, required double value}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSize = value;
        });
      },
      child: Container(
        width: 90,
        height: 45,
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        decoration: BoxDecoration(
          border: Border.all(
              color: LightColor.iconColor,
              style:
                  groupValue == value ? BorderStyle.solid : BorderStyle.none),
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: groupValue == value
              ? LightColor.kPrimaryColor
              : LightColor.kPrimaryLightColor,
        ),
        child: Center(
          child: TitleText(
            text: value % 1 == 0
                ? 'US ' + (value ~/ 1).toString()
                : 'US ' + value.toString(),
            fontSize: 16,
            color: groupValue == value
                ? LightColor.bgColor
                : LightColor.titleTextColor,
          ),
        ),
      ),
    );
  }

  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const TitleText(
          text: "Available Color",
          fontSize: 14,
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _colorButton(LightColor.yellowColor, selectedColor),
            const SizedBox(
              width: 30,
            ),
            _colorButton(LightColor.lightBlue, selectedColor),
            const SizedBox(
              width: 30,
            ),
            _colorButton(LightColor.black, selectedColor),
            const SizedBox(
              width: 30,
            ),
            _colorButton(LightColor.red, selectedColor),
            const SizedBox(
              width: 30,
            ),
            _colorButton(LightColor.skyBlue, selectedColor),
          ],
        )
      ],
    );
  }

  Widget _colorButton(Color color, Color? groupColor) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: CircleAvatar(
        radius: 12,
        backgroundColor: color.withAlpha(150),
        child: color == groupColor
            ? Icon(
                Icons.check_circle,
                color: color,
                size: 18,
              )
            : CircleAvatar(radius: 7, backgroundColor: color),
      ),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const TitleText(
          text: "Description",
          fontSize: 14,
        ),
        const SizedBox(height: kDefaultPadding),
        Text(widget.product.description),
      ],
    );
  }

  FloatingActionButton _floatingButton(Product product, double size) {
    return FloatingActionButton(
      onPressed: () {
        if (size != 0) {
          const snackBar = SnackBar(
            content: Text('Added to your Cart!'),
            backgroundColor: LightColor.kPrimaryColor,
            duration: Duration(milliseconds: 600),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          context.read<CartBloc>().add(
                CartProductAdded(
                  CartItem(
                    id: product.id + '-' + selectedSize.toString(),
                    title: product.title,
                    productId: product.id,
                    imageUrl: product.imageUrl.first,
                    price: product.price,
                    size: selectedSize,
                  ),
                ),
              );
        }
      },
      backgroundColor: LightColor.kPrimaryColor,
      child: const Icon(
        Icons.shopping_basket,
        //color: Theme.of(context).floatingActionButtonTheme.backgroundColor
      ),
    );
  }
}
