import 'package:flutter/widgets.dart';
import 'package:polimi_app/screens/chooseRolePage/choose_role_page.dart';
import 'auth_manager.dart';
import 'screens/home_page/products_screen.dart';
import 'screens/register_success/register_success_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_in/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  ProductsScreen.routeName: (context) => ProductsScreen(),
  AuthManager.routeName: (context) => AuthManager(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  RegisterSuccessScreen.routeName: (context) => RegisterSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ChooseRolePage.routeName: (context) => ChooseRolePage()
};
