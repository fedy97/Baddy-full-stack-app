import 'package:flutter/material.dart';
import 'package:polimi_app/models/model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

Widget _field(
    {BuildContext context,
    String title,
    String value,
    IconData icon,
    bool isPhone,
    int index}) {
  return GestureDetector(
      onTap: () async {
        if (isPhone != null) {
          var url = "tel:$value";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        }
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: index.isEven ? kPrimaryColor : kSecondaryColor,
          boxShadow: [kDefaultShadow],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                icon,
                color: kSecondaryColor,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '$title:',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                value ?? "",
                style: TextStyle(fontSize: 15, color: kSecondaryColor),
              )
            ],
          ),
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ));
}

Widget buildUserProfileList(BuildContext context, Model model) {
  return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          _field(
              index: 0,
              context: context,
              title: "Nome",
              value: model.selectedUser.firstName,
              icon: Icons.person),
          SizedBox(
            height: 20,
          ),
          _field(
              index: 1,
              context: context,
              title: "Cognome",
              value: model.selectedUser.lastName,
              icon: Icons.person),
          SizedBox(
            height: 20,
          ),
          _field(
              index: 2,
              context: context,
              title: "Phone",
              value: model.selectedUser.phone,
              icon: Icons.phone,
              isPhone: true),
          SizedBox(
            height: 20,
          ),
          _field(
              index: 3,
              context: context,
              title: "City",
              value: model.selectedUser.city,
              icon: Icons.location_city),
          SizedBox(
            height: 20,
          ),
          _field(
              index: 4,
              context: context,
              title: "Nationality",
              value: model.selectedUser.nationality,
              icon: Icons.place),
          SizedBox(
            height: 20,
          ),
          _field(
              index: 5,
              context: context,
              title: "Gender",
              value: model.selectedUser.gender,
              icon: Icons.place),
          SizedBox(
            height: 20,
          ),
          _field(
              index: 6,
              context: context,
              title: "Age",
              value: model.selectedUser.birth != null
                  ? _calculateAge(model.selectedUser.birth)
                  : "",
              icon: Icons.accessibility_sharp)
        ],
      ));
}

String _calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age.toString();
}
