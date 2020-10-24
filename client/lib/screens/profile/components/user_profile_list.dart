import 'package:flutter/material.dart';
import 'package:polimi_app/models/model.dart';

import '../../../constants.dart';

Widget _field(
    {BuildContext context, String title, String value, IconData icon}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      color: kPrimaryColor,
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
  );
}

Widget buildUserProfileList(BuildContext context, Model model) {
  return Column(
    children: [
      _field(
          context: context,
          title: "Nome",
          value: model.selectedUser.firstName,
          icon: Icons.person),
      SizedBox(
        height: 20,
      ),
      _field(
          context: context,
          title: "Cognome",
          value: model.selectedUser.lastName,
          icon: Icons.person)
    ],
  );
}
