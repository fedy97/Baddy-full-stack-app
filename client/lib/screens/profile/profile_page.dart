import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:polimi_app/components/profile_widgets.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/screens/profile/components/write_review.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/user_profile_list.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = '/profile';

  static final GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    try {
      final model = Provider.of<Model>(context, listen: false);
      print('built profile page');
      return WillPopScope(
        //when press the back button
          onWillPop: () async {
            //do not rebuild the listview here, page is closing
            model.setCurrentProfilePage(0, false);
            return true;
          },
          child: Scaffold(
              bottomNavigationBar: _buildBottomNavBar(model),
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: kPrimaryColor,
                elevation: 0.0,
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
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
                        Selector<Model, int>(
                            builder: (context, data, child) {
                              switch (data) {
                                case 0:
                                  return buildUserProfileList(context, model);
                                  break;
                                case 1:
                                  return Container();
                                  break;
                                case 2:
                                  return WriteReviewWidget();
                                  break;
                                default:
                                  return Container();
                              }
                            },
                            selector: (_, model) => model.currentProfilePage),
                      ],
                    ),
                  ),
                ],
              )));
    } catch (e, trace) {
      print(e);
      return Container();
    }
  }

  Widget _circleAvatar(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    //TODO correct rebuild error on will pop, when writing a review this will throw error
    return Hero(
        tag: '${model.selectedUser.username}',
        child: photoProfile(
            photo: model.selectedUser.photo,
            size: MediaQuery.of(context).size.width / 2));
  }

  Widget _buildBottomNavBar(Model model) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 50,
      items: [
        Icon(
          Icons.person,
          color: Colors.white,
          size: 30,
        ),
        Icon(
          Icons.star,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ],
      color: kPrimaryColor,
      buttonBackgroundColor: kPrimaryColor,
      backgroundColor: Colors.white,
      onTap: (index) {
        model.setCurrentProfilePage(index, true);
      },
    );
  }
}
