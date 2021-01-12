import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polimi_app/components/profile_widgets.dart';
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
                color: !itemIndex.isEven ? kPrimaryColor : kSecondaryColor,
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
                  child: photoProfile(photo: user.photo, size: getProportionateScreenHeight(100))),
            ),
            // User title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, that's why we set out total width - 200
                width: MediaQuery.of(context).size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Nome: ${user.firstName.length >= 10 ? user.firstName.toUpperCase().substring(0,9) : user.firstName.toUpperCase()}",
                        style: GoogleFonts.montserrat(color: kSecondaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Citta: ${user.city.toUpperCase()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.deepPurple),
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 1.3, // 30 padding
                            vertical: kDefaultPadding / 3, // 5 top and bottom
                          ),
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                          ),
                          child: Text(
                            "${99}€/h",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: IconTheme(
                            data: IconThemeData(
                              color: Colors.amber,
                              size: 20,
                            ),
                            child: RatingStars(
                                rate: user.ratingsQuantity == 0
                                    ? 0
                                    : user.ratingsAverage.toDouble()),
                          ),
                        ),
                      ],
                    ),
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
