import 'package:flutter/material.dart';
import 'package:polimi_app/components/custom_surfix_icon.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/models/model.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class UpdateProfile extends StatefulWidget {
  static String routeName = "/update-profile";
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
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

  Widget _circleAvatar() {
    return GestureDetector(
      onTap: () {
        print('change image');
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
            image: AssetImage('assets/images/girl.png'),
          ),
        ),
      ),
    );
  }

  Widget _textFormField({
    String hintText,
    String icon,
  }) {
    return TextFormField(
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/$icon"),
      ),
    );
  }

  Widget _textFormFieldCalling(Model model) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        _textFormField(
          hintText: 'Nome',
          icon: "User.svg",
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        _textFormField(
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
          press: () {
            //todo
          },
          text: "Aggiorna",
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    SizeConfig().init(context);
    return Scaffold(
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
      body: Stack(
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
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _profileText(),
                _circleAvatar(),
                _textFormFieldCalling(model)
              ],
            ),
          )
        ],
      ),
    );
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
