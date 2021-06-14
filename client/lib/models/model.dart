import 'package:flutter/material.dart';
import 'package:polimi_app/models/message.dart';
import 'package:polimi_app/models/review.dart';
import 'package:polimi_app/models/user/standardUser.dart';
import 'package:polimi_app/models/user/user.dart';
import 'package:polimi_app/services/apis.dart';

class Model extends ChangeNotifier {
  User _user;
  User _selectedUser;
  List<User> _availableUsers;
  List<User> _filteredUsers;
  int _currentProfilePage;

  //used during registration phase, to decide which kind of registration form use
  bool _isRegisteringAsStandard;
  Map<String, String> tempValues;

  Model() {
    _currentProfilePage = 0;
  }

  void setCurrentProfilePage(int index, bool rebuild) {
    _currentProfilePage = index;
    if (rebuild) notifyListeners();
  }

  void setUserPhoto(String photo) {
    //called here in order to rebuild UI
    user.setPhoto(photo);
    notifyListeners();
  }

  void setSelectedUser(User selected) {
    _selectedUser = selected;
    //notifyListeners();
  }

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

  Future<bool> get getReviewsByUser async {
    if (_selectedUser.reviewsAboutMe == null) {
      Map reviews =
          await Apis.getUserReviews(_selectedUser.username, _user.jwt);
      _selectedUser.reviewsAboutMe = Map();
      _selectedUser.reviewsAboutMe['length'] = reviews['results'];
      _selectedUser.reviewsAboutMe['reviews'] =
          _buildReviews(reviews['reviews']);
      return true;
    } else
      return true;
  }

  Future<bool> get getMessagesByUser async {
    Map messages = await Apis.getCaregiverMessages(_user.username, _user.jwt);
    _user.messagesForMe = Map();
    _user.messagesForMe['length'] = messages['results'];
    _user.messagesForMe['messages'] = _buildMessages(messages['messages']);
    return true;
  }

  List<Message> _buildMessages(List r) {
    var messages = List<Message>();
    r.forEach((message) {
      messages.add(new Message.fromMap(message, this));
    });
    return messages;
  }

  List<Review> _buildReviews(List r) {
    var reviews = List<Review>();
    r.forEach((review) {
      reviews.add(new Review.fromMap(review, this));
    });
    return reviews;
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

  User get selectedUser => _selectedUser;

  int get currentProfilePage => _currentProfilePage;
}
