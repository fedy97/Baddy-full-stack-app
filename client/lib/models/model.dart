import 'package:flutter/material.dart';
import 'package:polimi_app/models/user/user.dart';

class Model extends ChangeNotifier {
  User _user;
  List<User> _availableUsers;
  //used during registration phase, to decide which kind of registration form use
  bool _isRegisteringAsStandard;
  Map<String, String> tempValues;


  bool get isRegisteringAsStandard => _isRegisteringAsStandard;

  set isRegisteringAsStandard(bool value) {
    _isRegisteringAsStandard = value;
  }

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  List<User> get availableUsers => _availableUsers;

  set availableUsers(List<User> value) {
    _availableUsers = value;
  }
}
