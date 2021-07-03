import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:polimi_app/components/alert_service.dart';
import 'package:polimi_app/components/custom_input_decoration.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/form_error.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/models/review.dart';
import 'package:polimi_app/services/apis.dart';
import 'package:polimi_app/size_config.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class WriteReviewWidget extends StatefulWidget {
  @override
  _WriteReviewWidgetState createState() => _WriteReviewWidgetState();
}

class _WriteReviewWidgetState extends State<WriteReviewWidget> {
  static double _currRate = 3.0;
  static String _review = "";
  final List<String> errors = [];
  static final _formKey = GlobalKey<FormState>();

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    //final detectKeyboard =
    //KeyboardVisibilityNotification().addNewListener(onHide: () {
    //  FocusScope.of(context).unfocus();
    //});
    final model = Provider.of<Model>(context, listen: false);
    return Column(
      children: [
        RatingBar.builder(
          initialRating: 3,
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
        SizedBox(
          height: getProportionateScreenHeight(50),
        ),
        _buildReviewFormField(),
        FormError(errors: errors),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: DefaultButton(
            key: Key("send_review"),
            press: (start, stop, state) async {
              if (_formKey.currentState.validate()) {
                try {
                  start();
                  Review currReview = Review(
                      review: _review,
                      rating: _currRate,
                      userReviewed: model.selectedUser);
                  Map result =
                      await Apis.sendReview(model.user.jwt, currReview.toMap());
                  stop();
                  if (result["status"] != "error")
                    AlertService().showAlert(
                      key: "success_snack",
                      context: context,
                      message: 'Review completed!',
                      type: AlertType.success,
                    );
                  else {
                    AlertService().showAlert(
                      context: context,
                      message: 'Something went wrong',
                      type: AlertType.error,
                    );
                  }
                } catch (e) {
                  stop();
                  AlertService().showAlert(
                    context: context,
                    message: 'Something went wrong',
                    type: AlertType.error,
                  );
                }
                stop();
              }
            },
            text: "Send",
          ),
        ),
      ],
    );
  }

  Form _buildReviewFormField() {
    return Form(
        key: _formKey,
        child: TextFormField(
          key: Key("write_review"),
          maxLines: 10,
          minLines: 5,
          style: TextStyle(
            color: kSecondaryColor,
          ),
          onSaved: (newValue) => _review = newValue,
          onChanged: (value) {
            _review = value;
            if (value.isNotEmpty) {
              removeError(error: kReviewNullError);
            }
            return null;
          },
          validator: (value) {
            if (value.isEmpty) {
              addError(error: kReviewNullError);
              return "";
            }
            return null;
          },
          decoration:
              customInputDecoration(title: "Review", iconName: "Star"),
        ));
  }
}
