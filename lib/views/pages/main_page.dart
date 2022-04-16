import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../cubit/bottom_nav_bar/home_cubit.dart';
import '../../cubit/bottom_nav_bar/home_state.dart';
import '../../themes/light_color.dart';
import 'favorites_page.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'shop_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MainPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const MainView();
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
      //appBar: buildAppBar(),
      body: SafeArea(
        child: IndexedStack(
          index: selectedTab.index,
          children: const [
            ShopPage(),
            FavoritePage(),
            CartPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.home,
              // icon: const Icon(
              //   Icons.home,
              // ),
              icon: selectedTab == HomeTab.home
                  ? SvgPicture.asset(
                      'assets/icons/Home-fill.svg',
                      color: LightColor.kPrimaryColor,
                    )
                  : SvgPicture.asset(
                      'assets/icons/Home.svg',
                      color: LightColor.darkGrey,
                    ),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.favorites,
              // icon: const Icon(
              //   Icons.favorite,
              // ),
              icon: selectedTab == HomeTab.favorites
                  ? SvgPicture.asset(
                      'assets/icons/Heart-fill.svg',
                      color: LightColor.kPrimaryColor,
                    )
                  : SvgPicture.asset(
                      'assets/icons/Heart.svg',
                      color: LightColor.darkGrey,
                    ),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.cart,
              // icon: const Icon(
              //   Icons.shopping_bag,
              // ),
              icon: selectedTab == HomeTab.cart
                  ? SvgPicture.asset(
                      'assets/icons/Cart-fill.svg',
                      color: LightColor.kPrimaryColor,
                    )
                  : SvgPicture.asset(
                      'assets/icons/Cart.svg',
                      color: LightColor.darkGrey,
                    ),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.profile,
              // icon: const Icon(
              //   Icons.person,
              // ),
              icon: selectedTab == HomeTab.profile
                  ? SvgPicture.asset(
                      'assets/icons/Profile-fill.svg',
                      color: LightColor.kPrimaryColor,
                    )
                  : SvgPicture.asset(
                      'assets/icons/Profile.svg',
                      color: LightColor.darkGrey,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Image.asset(
        'assets/icons/nike_logo.png',
        height: AppBar().preferredSize.height * 0.6,
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
  }) : super(key: key);
  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      icon: icon,
      iconSize: 32,
    );
  }
}
