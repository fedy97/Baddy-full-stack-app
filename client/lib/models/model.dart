import 'package:flutter/material.dart';
import 'package:polimi_app/models/user/standardUser.dart';
import 'package:polimi_app/models/user/user.dart';

class Model extends ChangeNotifier {
  User _user;
  List<User> _availableUsers;
  List<User> _filteredUsers;

  //used during registration phase, to decide which kind of registration form use
  bool _isRegisteringAsStandard;
  Map<String, String> tempValues;

  void storeAvailableUsers(Map payload) {
    //var length = payload["length"];
    List users = payload["data"];
    _availableUsers = List();
    _filteredUsers = List();
    users.forEach((user) {
      User u = new StandardUser.fromMap(user, "empty");
      _availableUsers.add(u);
      _filteredUsers.add(u);
    });
  }

  void setFilter(String city) {
    _filteredUsers.clear();
    _availableUsers.forEach((user) {
      if (user.city.toLowerCase().contains(city))
        _filteredUsers.add(user);
      else
        _filteredUsers.remove(user);
    });
    //update ui
    notifyListeners();
  }

  List<User> get filteredUsers => _filteredUsers;

  bool get isRegisteringAsStandard => _isRegisteringAsStandard;

  set isRegisteringAsStandard(bool value) {
    _isRegisteringAsStandard = value;
  }

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  List<User> get availableUsers => _availableUsers;
}
