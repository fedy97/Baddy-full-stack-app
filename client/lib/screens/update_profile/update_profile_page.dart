import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:polimi_app/components/alert_service.dart';
import 'package:polimi_app/components/custom_input_decoration.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/profile_widgets.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/services/apis.dart';
import 'package:polimi_app/services/utils.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class UpdateProfile extends StatelessWidget {
  static String routeName = "/update-profile";
  static final _scaffoldKey = GlobalKey<ScaffoldState>();
  static String firstName;
  static String lastName;
  static String phone;
  static String city;
  static String gender;

  Widget _textFormField(
      {String initialValue, String hintText, String icon, Function onChanged}) {
    return TextFormField(
      style: TextStyle(
        color: kSecondaryColor,
      ),
      //put empty string if init value is null
      initialValue: initialValue ?? '',
      onChanged: onChanged,
      decoration: customInputDecoration(title: hintText, iconName: icon),
    );
  }

  Widget _textFormFieldCalling(Model model, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        _textFormField(
          initialValue: model.user.firstName,
          onChanged: (value) {
            firstName = value;
          },
          hintText: 'Nome',
          icon: "User",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          initialValue: model.user.lastName,
          onChanged: (value) {
            lastName = value;
          },
          hintText: 'Cognome',
          icon: "User",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(hintText: 'Available', icon: "Lock"),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'Phone',
          icon: "Phone",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'City',
          icon: "Phone",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'Gender',
          icon: "Phone",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'Nationality',
          icon: "Phone",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'Birth',
          icon: "Phone",
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        DefaultButton(
            text: "Aggiorna",
            press: (startLoading, stopLoading, btnState) async {
              try {
                startLoading();
                //Utils.showProgress(context);
                model.user.firstName = firstName ?? model.user.firstName;
                model.user.lastName = lastName ?? model.user.lastName;
                await Apis.updateProfile(model.user.jwt, model.user.toMap());
                stopLoading();
                AlertService().showAlert(
                  context: context,
                  message: 'Profilo aggiornato con successo!',
                  type: AlertType.success,
                );
                //Utils.showSnack(key: _scaffoldKey, text: "Utente Aggiornato!");
              } catch (e) {
                stopLoading();
                AlertService().showAlert(
                  context: context,
                  message: 'Controlla i dati inseriti',
                  type: AlertType.error,
                );
              }
            }),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }

  Widget _circleAvatar(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return Stack(
      children: [
        photoProfile(
            photo: context.select((Model model) => model.user.photo),
            size: SizeConfig.screenWidth / 2),
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
    final detectKeyboard =
        KeyboardVisibilityNotification().addNewListener(onHide: () {
      FocusScope.of(context).unfocus();
    });
    print('built update profile page');
    final model = Provider.of<Model>(context, listen: false);
    SizeConfig().init(context);
    return GestureDetector(
        onTap: () {
          Utils.hideKeyboard(context: context);
        },
        child: Scaffold(
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
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
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
          ),
        ));
  }
}
