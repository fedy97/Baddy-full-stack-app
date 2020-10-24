import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:polimi_app/components/custom_input_decoration.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/models/model.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class WriteReviewWidget extends StatelessWidget {
  static double _currRate = 0.0;
  static String _review = "";

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return Column(
      children: [
        RatingBar(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            _currRate = rating;
          },
        ),
        SizedBox(height: 50,),
        TextFormField(
          maxLines: 10,
          minLines: 5,
          style: TextStyle(
            color: kSecondaryColor,
          ),
          decoration: customInputDecoration(title: "Recensione", iconName: "Star"),
          onChanged: (val) {
            _review = val;
          },
        ),
        DefaultButton(
          press: (start, stop, state) {
            start();
            //sleep(Duration(seconds: 2));
            stop();
          },
          text: "Invia",
        )
      ],
    );
  }
}
