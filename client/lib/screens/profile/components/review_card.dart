import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polimi_app/components/rating_stars.dart';
import 'package:polimi_app/models/review.dart';

import '../../../constants.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    this.itemIndex,
    this.review,
  }) : super(key: key);

  final int itemIndex;
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: InkWell(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 136,
              decoration: BoxDecoration(
                border: Border.all(
                    color: !itemIndex.isEven ? kPrimaryColor : kSecondaryColor),
                borderRadius: BorderRadius.circular(22),
                color: !itemIndex.isEven ? kPrimaryColor : kSecondaryColor,
              ),
              child: Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // User title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
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
                        "Username: ${review.userReviewer.username}",
                        style: GoogleFonts.montserrat(
                            color: kSecondaryColor, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Row(
                        children: [
                          Text(
                            "Vote:",
                            style: GoogleFonts.montserrat(
                                color: kSecondaryColor, fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconTheme(
                            data: IconThemeData(
                              color: Colors.amber,
                              size: 20,
                            ),
                            child: RatingStars(rate: review.rating),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Row(
                          children: [
                            Text(
                              "Review:",
                              style: GoogleFonts.montserrat(
                                  color: kSecondaryColor, fontSize: 16),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                AwesomeDialog(
                                  dialogType: DialogType.NO_HEADER,
                                  btnOkColor: kSecondaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  context: context,
                                  buttonsBorderRadius:
                                      BorderRadius.all(Radius.circular(22)),
                                  headerAnimationLoop: false,
                                  animType: AnimType.TOPSLIDE,
                                  title: 'Review',
                                  desc: review.review,
                                  btnOkOnPress: () {},
                                )..show();
                              },
                              child: Text(
                                "Show",
                                style: GoogleFonts.montserrat(
                                    color: kSecondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
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
