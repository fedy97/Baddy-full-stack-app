import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polimi_app/models/user/user.dart';
import 'package:polimi_app/services/access_manager.dart';
import 'package:provider/provider.dart';

import '../../auth_manager.dart';
import '../../constants.dart';
import 'components/body.dart';

class ProductsScreen extends StatelessWidget {
  static String routeName= '/products';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }

  AppBar buildAppBar(context) {
    User user = Provider.of<User>(context, listen: true);
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text(user.username),
      actions: <Widget>[
        IconButton(
          color: Colors.white,
          icon: SvgPicture.asset("assets/icons/Log_out.svg"),
          onPressed: () async {
            await AccessManager.signOut();
            Navigator.pushNamed(context, AuthManager.routeName);
          },
        ),
      ],
    );
  }
}
