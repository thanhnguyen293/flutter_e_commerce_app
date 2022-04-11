import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_e_commerce_app/bloc/bottom_nav_bar/home_cubit.dart';
import 'package:flutter_e_commerce_app/bloc/bottom_nav_bar/home_state.dart';
import 'package:flutter_e_commerce_app/bloc/category/category_bloc.dart';
import 'package:flutter_e_commerce_app/bloc/wishlist/wishlist_bloc.dart';
import 'package:flutter_e_commerce_app/cubit/update_profile/update_password_cubit.dart';
import 'package:flutter_e_commerce_app/themes/theme.dart';
import 'package:flutter_e_commerce_app/views/pages/sign_up/sign_up_page.dart';

import '../bloc/bloc_observer.dart';
import '../controller/auth_repository.dart';
import 'bloc/app/app_bloc.dart';
import 'bloc/app/app_state.dart';
import 'bloc/cart/cart_bloc.dart';
import 'config/app_router.dart';

import 'bloc/product/product_bloc.dart';
import 'controller/category/category_repository.dart';
import 'controller/product/product_repository.dart';
import 'views/pages/login/login_page.dart';
import 'views/pages/main_page.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authenticationRepository = AuthRepository();
      await authenticationRepository.user.first;
      runApp(
        MyApp(
          authenticationRepository: authenticationRepository,
        ),
      );
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required AuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                AppBloc(authenticationRepository: _authenticationRepository),
          ),
          BlocProvider(
            create: (_) =>
                CategoryBloc(categoryRepository: CategoryRepository())
                  ..add(LoadCategories()),
          ),
          BlocProvider(
            create: (_) => ProductBloc(productRepository: ProductRepository())
              ..add(LoadProducts()),
          ),
          BlocProvider(
            create: (_) => CartBloc()..add(LoadCart()),
          ),
          BlocProvider(
            create: (_) => HomeCubit(),
          ),
          BlocProvider(
            create: (_) => UpdatePasswordCubit(_authenticationRepository),
          ),
          BlocProvider(create: (_) => WishlistBloc()..add(LoadWishlist()))
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            switch (state.status) {
              case AppStatus.authenticated:
                {
                  context.read<HomeCubit>().setTab(HomeTab.home);
                  _navigator.pushAndRemoveUntil<void>(
                    MainPage.route(),
                    (route) => false,
                  );
                }

                break;
              case AppStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      //onGenerateRoute: (_) => SplashPage.route(),
      // home: FlowBuilder<AppStatus>(
      //   state: context.select((AppBloc bloc) => bloc.state.status),
      //   onGeneratePages: onGenerateAppViewPages,
      // ),
      // home: const MainPage(),
      // routes: {
      //   TestPage.routeName: (context) => const TestPage(),
      // },
      onGenerateRoute: AppRouter.onGenerateRoute,
      // initialRoute: LoginPage.routeName,
    );
  }

  // List<Page> onGenerateAppViewPages(AppStatus state, List<Page> pages) {
  //   switch (state) {
  //     case AppStatus.authenticated:
  //       return [MainPage.page()];
  //     case AppStatus.unauthenticated:
  //       return [LoginPage.page()];
  //   }
  // }
}
