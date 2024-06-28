import 'package:flutter/material.dart';
import 'package:think_ninjas_app/screens/kitchen_main_screen.dart';
import 'package:think_ninjas_app/screens/password.dart';
import 'package:think_ninjas_app/screens/user_main_screen.dart';
import 'package:think_ninjas_app/screens/waiter_main_screen.dart';
import 'package:think_ninjas_app/screens/roll_selector_screen.dart';

class AppRouter {
  static const String rollSelector = '/screens/roll_selector';
  static const String kitchenMain = '/screens/kitchen_main';
  static const String userMain = '/screens/user_main';
  static const String waiterMain = '/screens/waiter_main';
  static const String password = '/screens/password_screen';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case rollSelector:
        return MaterialPageRoute(builder: (_) => RollSelector());
      case kitchenMain:
        return MaterialPageRoute(builder: (_) => KitchenScreen());
      case userMain:
        return MaterialPageRoute(builder: (_) => UserScreen());
      case waiterMain:
        return MaterialPageRoute(builder: (_) => WaiterScreen());
      case password:
        if (args == 'waiter') {
          return MaterialPageRoute(builder: (_) => PasswordScreen(route: 'waiter'));
        } else if (args == 'kitchen') {
          return MaterialPageRoute(builder: (_) => PasswordScreen(route: 'kitchen'));
        } else {
          return MaterialPageRoute(builder: (_) => RollSelector());
        }
      default:
        return null;
    }
  }
}
