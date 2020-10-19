import 'package:flutter/widgets.dart';
import 'package:polimi_app/screens/chooseRolePage/choose_role_page.dart';
import 'package:polimi_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:polimi_app/screens/update_profile/update_profile_page.dart';
import 'auth_manager.dart';
import 'screens/home_page/home_page.dart';
import 'screens/register_success/register_success_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_in/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => HomePage(),
  AuthManager.routeName: (context) => AuthManager(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  RegisterSuccessScreen.routeName: (context) => RegisterSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ChooseRolePage.routeName: (context) => ChooseRolePage(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  UpdateProfile.routeName: (context) => UpdateProfile()
};
