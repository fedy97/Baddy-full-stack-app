import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polimi_app/models/user/user.dart';
import 'package:polimi_app/services/access_manager.dart';
import 'package:polimi_app/services/apis.dart';
import 'package:provider/provider.dart';

import '../../auth_manager.dart';
import '../../constants.dart';
import 'components/body.dart';

class ProductsScreen extends StatelessWidget {
  static String routeName = '/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: kPrimaryColor,
        body: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Body();
            },
            future: Apis.getAvailableUsers(context.watch<User>().jwt)) //Body(),
        );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text('${context.watch<User>().username}'),
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
