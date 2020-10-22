import 'package:flutter/material.dart';
import 'package:polimi_app/components/rating_stars.dart';
import 'package:polimi_app/models/user/user.dart';
import 'package:polimi_app/size_config.dart';

import '../../../constants.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    this.itemIndex,
    this.user,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final User user;
  final Function press;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? kPrimaryColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our user image
            Positioned(
              top: 36,
              right: 30,
              child: Hero(
                tag: '${user.username}',
                child: Container(
                  width: getProportionateScreenWidth(100),
                  height: getProportionateScreenHeight(100),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: itemIndex.isEven ? kPrimaryColor : kSecondaryColor, width: 1),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: user.photo ==
                          'default.jpg'
                          ? AssetImage('assets/images/girl.png')
                          : NetworkImage(user.photo),
                    ),
                  ),
                ),
              ),
            ),
            // User title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Nome: ${user.firstName.toUpperCase()}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepPurple),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Citta: ${user.city.toUpperCase()}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepPurple),
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5, // 30 padding
                          vertical: kDefaultPadding / 4, // 5 top and bottom
                        ),
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                        ),
                        child: Text(
                          "\$${1}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: IconTheme(
                          data: IconThemeData(
                            color: Colors.amber,
                            size: 20,
                          ),
                          child: RatingStars(rate: user.ratingsQuantity == 0 ? 0 : user.ratingsAverage),
                        ),
                      ),

                    ],),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
