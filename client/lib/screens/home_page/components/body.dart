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
                //rebuild only the listview. And only if filteredUsers.length changes,
                //so if other attributes of Model changes, this will not rebuild.
                Selector<Model, int>(
                  selector: (_, model) => model.filteredUsers.length,
                  builder: (_, data, child) => ListView.builder(
                    itemCount: data,
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
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
