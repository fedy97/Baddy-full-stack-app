import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
      style: TextStyle(
          fontSize: getProportionateScreenWidth(28),
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget photoProfile({@required String photo, @required double size}) {
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(300.0),
      child: photo == 'default.jpg'
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
