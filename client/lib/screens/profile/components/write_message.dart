import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:polimi_app/components/alert_service.dart';
import 'package:polimi_app/components/custom_input_decoration.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/form_error.dart';
import 'package:polimi_app/models/message.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/models/review.dart';
import 'package:polimi_app/services/apis.dart';
import 'package:polimi_app/size_config.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class WriteMessageWidget extends StatefulWidget {
  @override
  _WriteMessageWidgetState createState() => _WriteMessageWidgetState();
}

class _WriteMessageWidgetState extends State<WriteMessageWidget> {
  static String _message = "";
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
            key: Key("send_message"),
            press: (start, stop, state) async {
              if (_formKey.currentState.validate()) {
                try {
                  start();
                  Message currMessage = Message(
                    userMessaged: model.selectedUser,
                    message: _message
                  );
                  Map result =
                      await Apis.sendMessage(model.user.jwt, currMessage.toMap());
                  stop();
                  if (result["status"] != "error")
                    AlertService().showAlert(
                      context: context,
                      message: 'Message Sent!',
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
          key: Key("write_message"),
          maxLines: 10,
          minLines: 5,
          style: TextStyle(
            color: kSecondaryColor,
          ),
          onSaved: (newValue) => _message = newValue,
          onChanged: (value) {
            _message = value;
            if (value.isNotEmpty) {
              removeError(error: kMessageNullError);
            }
            return null;
          },
          validator: (value) {
            if (value.isEmpty) {
              addError(error: kMessageNullError);
              return "";
            }
            return null;
          },
          decoration:
              customInputDecoration(title: "Message", iconName: "Mail"),
        ));
  }
}
