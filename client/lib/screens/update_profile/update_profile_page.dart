import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polimi_app/components/alert_service.dart';
import 'package:polimi_app/components/custom_input_decoration.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/profile_widgets.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/services/apis.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../size_config.dart';
import 'components/date_picker.dart';

class UpdateProfile extends StatelessWidget {
  static String routeName = "/update-profile";
  static final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final _formKey = GlobalKey<FormState>();
  static String firstName;
  static String lastName;
  static String phone;
  static String price;
  static String city;
  static String gender;
  static DateTime birth;
  static String nationality;
  static bool available;

  TextFormField _textFormField(
      {String initialValue, String hintText, String icon, Function onChanged}) {
    return TextFormField(
      keyboardType: (hintText == 'Phone' || hintText == 'Price') ? TextInputType.number : TextInputType.text,
      style: GoogleFonts.montserrat(color: kSecondaryColor),
      //put empty string if init value is null
      initialValue: initialValue ?? '',
      onChanged: onChanged,
      decoration: customInputDecoration(title: hintText, iconName: icon),
    );
  }

  int _getGenderIndex(String gender) {
    return gender == 'male' ? 0 : 1;
  }

  String _getGenderFromIndex(int index) {
    switch (index) {
      case 0:
        return "male";
        break;
      case 1:
        return "female";
        break;
      case 2:
        return null;
        break;
      default:
        return null;
    }
  }

  Widget _textFormFieldCalling(Model model, BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(30)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Available: ",
                      style: GoogleFonts.montserrat(
                          color: kSecondaryColor, fontWeight: FontWeight.bold)),
                  ToggleSwitch(
                    initialLabelIndex: model.user.available == true ? 0 : 1,
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColor: kSecondaryColor,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.white,
                    inactiveFgColor: kPrimaryColor,
                    labels: ['YES', 'NO'],
                    icons: [FontAwesomeIcons.check, FontAwesomeIcons.times],
                    onToggle: (index) {
                      available = index == 0 ? true : false;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            ToggleSwitch(
              initialLabelIndex: model.user.gender == null
                  ? 2
                  : _getGenderIndex(model.user.gender),
              minWidth: MediaQuery.of(context).size.width / 4 + 12,
              minHeight: 60,
              cornerRadius: 50.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.white,
              inactiveFgColor: kPrimaryColor,
              fontSize: 20,
              labels: ['M', 'F', 'X'],
              icons: [
                FontAwesomeIcons.mars,
                FontAwesomeIcons.venus,
                FontAwesomeIcons.transgender
              ],
              activeBgColor: kSecondaryColor,
              onToggle: (index) {
                gender = _getGenderFromIndex(index);
                model.user.gender = gender;
              },
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            _textFormField(
              initialValue: model.user.firstName,
              onChanged: (value) {
                firstName = value;
              },
              hintText: 'First Name',
              icon: "User",
            ),
            SizedBox(height: getProportionateScreenHeight(12)),
            _textFormField(
              initialValue: model.user.lastName,
              onChanged: (value) {
                lastName = value;
              },
              hintText: 'Last Name',
              icon: "User",
            ),
            SizedBox(height: getProportionateScreenHeight(12)),
            _textFormField(
              initialValue: model.user.phone,
              onChanged: (value) {
                phone = value;
              },
              hintText: 'Phone',
              icon: "Phone",
            ),
            SizedBox(height: getProportionateScreenHeight(12)),
            _textFormField(
              initialValue: model.user.price != null ? model.user.price.toString() : '',
              onChanged: (value) {
                price = value;
              },
              hintText: 'Price',
              icon: "Gift Icon",
            ),
            SizedBox(height: getProportionateScreenHeight(12)),
            _textFormField(
              initialValue: model.user.city,
              onChanged: (value) {
                city = value;
              },
              hintText: 'City',
              icon: "Phone",
            ),
            SizedBox(height: getProportionateScreenHeight(12)),
            _textFormField(
              initialValue: model.user.nationality,
              onChanged: (value) {
                nationality = value;
              },
              hintText: 'Nationality',
              icon: "Phone",
            ),
            SizedBox(height: getProportionateScreenHeight(12)),
            MyTextFieldDatePicker(
              labelText: "Birth",
              prefixIcon: Icon(Icons.date_range),
              suffixIcon: Icon(Icons.arrow_drop_down),
              lastDate: DateTime(DateTime.now().year - 18, 1),
              initialDate: model.user.birth,
              onDateChanged: (selectedDate) {
                birth = selectedDate;
              },
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            DefaultButton(
                text: "Update",
                press: (startLoading, stopLoading, btnState) async {
                  try {
                    startLoading();
                    model.user.price = price ?? model.user.price;
                    model.user.firstName = firstName ?? model.user.firstName;
                    model.user.lastName = lastName ?? model.user.lastName;
                    model.user.phone = phone ?? model.user.phone;
                    model.user.gender = gender ?? model.user.gender;
                    model.user.nationality =
                        nationality ?? model.user.nationality;
                    model.user.city = city ?? model.user.city;
                    model.user.birth = birth ?? model.user.birth;
                    model.user.available = available ?? model.user.available;

                    await Apis.updateProfile(
                        model.user.jwt, model.user.toMap());
                    stopLoading();
                    //TODO update this to show also error returned
                    AlertService().showAlert(
                      context: context,
                      message: 'Profile updated',
                      type: AlertType.success,
                    );
                  } catch (e) {
                    stopLoading();
                    AlertService().showAlert(
                      context: context,
                      message: 'Please check your connection',
                      type: AlertType.error,
                    );
                  }
                }),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ));
  }

  Stack _circleAvatar(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return Stack(
      children: [
        photoProfile(
            photo: context.select((Model model) => model.user.photo),
            size: 400 / 2),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  AwesomeDialog(
                    context: context,
                    headerAnimationLoop: false,
                    animType: AnimType.BOTTOMSLIDE,
                    btnOkText: "Camera",
                    btnCancelText: "Gallery",
                    btnOkColor: kSecondaryColor,
                    btnCancelColor: kSecondaryColor,
                    btnCancelOnPress: () async {
                      PickedFile f = await ImagePicker().getImage(
                          source: ImageSource.gallery, imageQuality: 10);
                      _sendImage(model, f);
                    },
                    btnOkOnPress: () async {
                      PickedFile f = await ImagePicker().getImage(
                          source: ImageSource.camera, imageQuality: 10);
                      _sendImage(model, f);
                    },
                    title: 'Select one',
                    desc: 'Camera or Gallery?',
                  )..show();
                }),
            decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor, width: 2),
                color: Colors.white,
                shape: BoxShape.circle),
          ),
        )
      ],
    );
  }

  _sendImage(Model model, PickedFile f) async {
    try {
      if (f != null) {
        String res = await Apis.uploadImage(
            image: f,
            username: model.user.username,
            timestamp: DateTime.now().millisecondsSinceEpoch,
            jwt: model.user.jwt);
        model.setUserPhoto(res);
      }
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    //final detectKeyboard =
    //    KeyboardVisibilityNotification().addNewListener(onHide: () {
    //  FocusScope.of(context).unfocus();
    //});
    print('built update profile page');
    final model = Provider.of<Model>(context, listen: false);
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: SafeArea(
            child: SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    CustomPaint(
                      child: Container(
                        width: 500,
                        height: 890,
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
                          _textFormFieldCalling(model, context)
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
