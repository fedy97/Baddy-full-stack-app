import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../size_config.dart';

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

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(0, size.height * 1);
    path.quadraticBezierTo(size.width * 0.04, size.height * 0.73,
        size.width * 0.21, size.height * 0.73);
    path.cubicTo(size.width * 0.36, size.height * 0.73, size.width * 0.64,
        size.height * 0.73, size.width * 0.79, size.height * 0.73);
    path.quadraticBezierTo(
        size.width * 1, size.height * 0.73, size.width, size.height * 1);
    path.lineTo(0, size.height * 1);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Widget profileText() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        gradient: kPrimaryGradientColor,
        boxShadow: [kDefaultShadow]),
    child: Text(
      'Profilo',
      style: GoogleFonts.montserrat(
          color: Colors.white, fontSize: getProportionateScreenWidth(30)),
    ),
  );
}

Widget photoProfile({@required String photo, @required double size}) {
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(300.0),
      child: (photo == null || photo == 'default.jpg')
          ? Image.asset('assets/images/girl.png')
          : CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: photo,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
    ),
    width: size,
    height: size,
    padding: EdgeInsets.all(1.0),
    decoration: BoxDecoration(
      boxShadow: [kDefaultShadow],
      border: Border.all(color: kSecondaryColor, width: 2),
      shape: BoxShape.circle,
      color: Colors.white,
    ),
  );
}
