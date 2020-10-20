import 'package:flutter/material.dart';
import 'package:polimi_app/models/review.dart';

import '../enum/role.dart';

abstract class User with ChangeNotifier {
  DateTime birth;
  String nationality;
  String gender;
  bool available;
  String username;
  String firstName;
  String lastName;
  String phone;
  String city;
  Role role;
  int ratingsQuantity;
  var ratingsAverage;
  String photo;
  String jwt;

  //store reviews about me
  List<Review> reviewsAboutMe;

  User(
      {@required this.jwt,
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

  void setPhoto(String photo) {
    this.photo = photo;
  }

  ///to map not required here, just a to string is ok
  @override
  String toString() {
    return {
      username,
      firstName,
      lastName,
      ratingsAverage,
      ratingsQuantity,
      role,
      available,
      phone
    }.toString();
  }

  Map toMap() {
    return {
      "lastName": lastName,
      "firstName": firstName,
      "phone": phone,
      "available": available,
      "nationality": nationality,
      "birth": birth
    };
  }
}
