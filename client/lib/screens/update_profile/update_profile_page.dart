import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polimi_app/components/custom_surfix_icon.dart';
import 'package:polimi_app/components/default_button.dart';
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

  Widget _profileText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Profilo',
        style: TextStyle(
          fontSize: getProportionateScreenWidth(36),
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _circleAvatar(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        try {
          PickedFile f = await ImagePicker()
              .getImage(source: ImageSource.gallery, imageQuality: 50);
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
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 5),
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: context.select((Model model) => model.user.photo) ==
                    'default.jpg'
                ? AssetImage('assets/images/girl.png')
                : NetworkImage(model.user.photo),
          ),
        ),
      ),
    );
  }

  Widget _textFormField(
      {String initialValue, String hintText, String icon, Function onChanged}) {
    return TextFormField(
      //put empty string if init value is null
      initialValue: initialValue ?? '',
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/$icon"),
      ),
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
          icon: "User.svg",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          initialValue: model.user.lastName,
          onChanged: (value) {
            lastName = value;
          },
          hintText: 'Cognome',
          icon: "User.svg",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(hintText: 'Available', icon: "Lock.svg"),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'Phone',
          icon: "Phone.svg",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'City',
          icon: "Phone.svg",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'Gender',
          icon: "Phone.svg",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'Nationality',
          icon: "Phone.svg",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
          hintText: 'Birth',
          icon: "Phone.svg",
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        DefaultButton(
          press: () async {
            try {
              Utils.showProgress(context);
              model.user.firstName = firstName ?? model.user.firstName;
              model.user.lastName = lastName ?? model.user.lastName;
              //model.user.available = available ?? model.user.firstName;
              //model.user.lastName = firstName ?? model.user.lastName;
              Map response =
                  await Apis.updateProfile(model.user.jwt, model.user.toMap());
              Navigator.pop(context);
              Utils.showSnack(key: _scaffoldKey, text: "Utente Aggiornato!");
            } catch (e) {
              print(e);
            }
          },
          text: "Aggiorna",
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('built update profile page');
    final model = Provider.of<Model>(context, listen: false);
    SizeConfig().init(context);
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                painter: HeaderCurvedContainer(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _profileText(),
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

//Color(0xff555555)
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = kPrimaryColor;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
