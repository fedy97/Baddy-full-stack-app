import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:polimi_app/components/profile_widgets.dart';
import 'package:polimi_app/models/model.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = '/profile';

  Widget _circleAvatar(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return Hero(
      tag: '${model.selectedUser.username}',
      child: photoProfile(photo: model.selectedUser.photo, size: SizeConfig.screenWidth / 2)
    );
  }

  @override
  Widget build(BuildContext context) {
    print('built profile page');
    final model = Provider.of<Model>(context, listen: false);
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
            ),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                CustomPaint(
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profileText(),
                      _circleAvatar(context),
                      SizedBox(
                        height: 50,
                      ),
                      _field(
                          context: context,
                          title: "Nome",
                          value: model.user.firstName,
                          icon: Icons.person),
                      SizedBox(
                        height: 20,
                      ),
                      _field(
                          context: context,
                          title: "Cognome",
                          value: model.user.lastName,
                          icon: Icons.person)
                    ],
                  ),
                )
              ],
            )));
  }

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
}
