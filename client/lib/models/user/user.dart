import 'package:flutter/material.dart';
import '../enum/role.dart';

abstract class User {
  String username;
  String firstName;
  String lastName;
  String phone;
  String address;
  String email;
  Role role;
  int ratingsQuantity;
  var ratingsAverage;
  String photo;
  String jwt;

  User(
      {@required this.jwt,
      @required this.email,
      @required this.username,
      @required this.role,
      @required this.photo,
      @required this.ratingsQuantity,
      this.ratingsAverage,
      this.firstName,
      this.lastName,
      this.phone,
      this.address});
}
