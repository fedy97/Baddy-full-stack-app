import 'package:flutter/widgets.dart';
import 'package:polimi_app/screens/choose_role_page/choose_role_page.dart';
import 'package:polimi_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:polimi_app/screens/profile/profile_page.dart';
import 'package:polimi_app/screens/update_profile/update_profile_page.dart';
import 'auth_manager.dart';
import 'screens/home_page/home_page.dart';
import 'screens/register_success/register_success_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_in/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';

// We use name route

final home = HomePage();
final auth = AuthManager();
final splash = SplashScreen();
final signin = SignInScreen();
final registerSuccess = RegisterSuccessScreen();
final signup = SignUpScreen();
final chooseRole = ChooseRolePage();
final completeProfile = CompleteProfileScreen();
final updateProfile = UpdateProfile();
final profile = ProfilePage();

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => home,
  AuthManager.routeName: (context) => auth,
  SplashScreen.routeName: (context) => splash,
  SignInScreen.routeName: (context) => signin,
  RegisterSuccessScreen.routeName: (context) => registerSuccess,
  SignUpScreen.routeName: (context) => signup,
  ChooseRolePage.routeName: (context) => chooseRole,
  CompleteProfileScreen.routeName: (context) => completeProfile,
  UpdateProfile.routeName: (context) => updateProfile,
  ProfilePage.routeName: (context) => profile
};
