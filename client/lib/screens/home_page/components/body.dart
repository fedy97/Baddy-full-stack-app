import 'package:flutter/material.dart';
import 'package:polimi_app/components/search_box.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/screens/profile/profile_page.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'user_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('built homepage');
    //here listen is set to false so that this widget will not be rebuilt
    //if notifyListeners is called. only the sub-widget below commented will rebuild thanks to watch()
    final model = Provider.of<Model>(context, listen: false);
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          SearchBox(onChanged: (value) {
            model.setFilter(value);
          }),
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: <Widget>[
                // Our background
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: context.select(
                      (Model modelWatch) => modelWatch.filteredUsers.length),
                  itemBuilder: (context, index) => UserCard(
                    itemIndex: index,
                    user: model.filteredUsers[index],
                    press: () async {
                      model.setSelectedUser(model.filteredUsers[index]);
                      await Navigator.pushNamed(context, ProfilePage.routeName);
                      model.setSelectedUser(null);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
