import 'package:flutter/material.dart';

import '../../constants.dart';
import 'list_messages.dart';

class MessagePage extends StatelessWidget {
  static String routeName = '/messages';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: ListMessagesWidget(),
    );
  }
}
