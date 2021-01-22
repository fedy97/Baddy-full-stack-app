import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/screens/update_profile/update_profile_page.dart';
import 'package:polimi_app/services/access_manager.dart';
import 'package:polimi_app/services/apis.dart';
import 'package:polimi_app/services/utils.dart';
import 'package:provider/provider.dart';

import '../../auth_manager.dart';
import '../../constants.dart';
import 'components/body.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/products';
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return GestureDetector(
        onTap: () {
          //Utils.hideKeyboard(context: context);
        },
        child: Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: kPrimaryColor,
        body: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData)
                return Utils.loadingWidget();
              else if (snapshot.data != null) {
                model.storeAvailableUsers(snapshot.data);
                return Body();
              } else
                return Text('lol');
            },
            future: Apis.getAvailableUsers(model.user.jwt)) //Body(),
    ));
  }

  AppBar buildAppBar(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text('Welcome, ${model.user.username}', style: GoogleFonts.montserrat(),),
      actions: <Widget>[
        model.user.role == 'user' ? SizedBox.shrink() : IconButton(
          icon: SvgPicture.asset(
            "assets/icons/User_Icon.svg",
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.pushNamed(context, UpdateProfile.routeName);
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/Log_out.svg",
            color: Colors.white,
          ),
          onPressed: () async {
            AwesomeDialog(
              context: context,
              headerAnimationLoop: false,
              animType: AnimType.BOTTOMSLIDE,
              btnOkText: "Logout",
              btnCancelText: "Delete",
              btnOkColor: Colors.red,
              btnCancelColor: kSecondaryColor,
              btnCancelOnPress: () async {},
              btnOkOnPress: () async {
                await AccessManager.signOut();
                Utils.popEverythingAndPush(
                    context: context, routeName: AuthManager.routeName);
              },
              title: 'Logout',
              desc: 'Are you sure?',
            )..show();
          },
        ),
      ],
    );
  }
}
