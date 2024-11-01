import 'package:aka_mercado/common/widgets/bottom_bar.dart';
import 'package:aka_mercado/features/admin/screens/add_product_screen.dart';
import 'package:aka_mercado/features/auth/screens/auth_screen.dart';
import 'package:aka_mercado/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch(routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings : routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings : routeSettings,
        builder: (_) => const HomeScreen(),
      );
      
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings : routeSettings,
        builder: (_) => const BottomBar(),
      );
      case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings : routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('La página no existe!'),
          ),
        ),
      );
  }
}