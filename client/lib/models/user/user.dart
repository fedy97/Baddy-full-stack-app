import 'package:flutter/material.dart';

abstract class User with ChangeNotifier {
  DateTime birth;
  String nationality;
  String gender;
  bool available;
  String username;
  String firstName;
  String lastName;
  String phone;
  String price;
  String city;
  String role;
  int ratingsQuantity;
  var ratingsAverage;
  String photo;
  String jwt;

  Map reviewsAboutMe;
  Map messagesForMe;

  User(
      {@required this.jwt,
      @required this.username,
      @required this.role,
      @required this.photo,
      @required this.ratingsQuantity,
      @required this.available,
      this.price,
      this.birth,
      this.nationality,
      this.gender,
      this.ratingsAverage,
      this.firstName,
      this.lastName,
      this.phone,
      this.city});

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
      "role": role,
      "lastName": lastName,
      "firstName": firstName,
      "phone": phone,
      "price": price,
      "available": available,
      "nationality": nationality,
      "birth": birth?.toString(),
      "gender": gender,
      "city": city
    };
  }
}
