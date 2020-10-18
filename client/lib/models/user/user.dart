import 'package:flutter/material.dart';
import 'package:polimi_app/models/enum/gender.dart';
import 'package:polimi_app/models/review.dart';

import '../enum/role.dart';

abstract class User with ChangeNotifier {
  DateTime birth;
  String nationality;
  Gender gender;
  bool available;
  String username;
  String firstName;
  String lastName;
  String phone;
  String city;
  String email;
  Role role;
  int ratingsQuantity;
  var ratingsAverage;
  String photo;
  String jwt;
  //store reviews about me
  List<Review> reviewsAboutMe;

  User(
      {@required this.jwt,
      @required this.email,
      @required this.username,
      @required this.role,
      @required this.photo,
      @required this.ratingsQuantity,
      @required this.available,
      this.birth,
      this.nationality,
      this.gender,
      this.ratingsAverage,
      this.firstName,
      this.lastName,
      this.phone,
      this.city})
      : reviewsAboutMe = List();

  ///to map not required here, just a to string is ok
  @override
  String toString() {
    return {email, username, role, available}.toString();
  }
}
