import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/screens/sign_in/sign_in_screen.dart';

class OnboardingPage extends StatefulWidget {
  static final style = GoogleFonts.montserrat();

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;

  @override
  void initState() {
    // TODO: implement initState
    liquidController = LiquidController();
    super.initState();
  }

  Widget _createSplashCard(String image, String title, String desc, bool type1) {
    return Container(
      decoration: BoxDecoration(
        gradient: type1 ? kPrimaryGradientColor : kSecondaryGradientColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 80,),
          Text(
            "Baddy",
            style: GoogleFonts.montserrat(color: type1 ? Colors.white : kPrimaryColor, fontSize: 50, fontWeight: FontWeight.w400),
          ),
          Padding(
            padding: EdgeInsets.all(50),
            child: Image.asset(image),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: GoogleFonts.montserrat(fontSize: 30, color: type1 ? Colors.white : kPrimaryColor),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(color: type1 ? Colors.white : kPrimaryColor, fontSize: 18 ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _createList() {
    return [
      _createSplashCard("assets/images/splash_1.png", "Qualche", "stronzata ma scritta in piccolo!!!", true),
      _createSplashCard("assets/images/splash_2.png", "Qualche", "stronzata ma scritta in piccolo!!!", false),
      _createSplashCard("assets/images/splash_3.png", "Qualche", "stronzata ma scritta in piccolo!!!", true),
    ];
  }

  Widget _buildDots(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return Container(
      width: 20,
      child: Center(
        child: Material(
          color: kPrimaryColor,
          type: MaterialType.card,
          child: Container(
            width: 6.0 * zoom,
            height: 6.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            LiquidSwipe(
              pages: _createList(),
              liquidController: liquidController,
              enableLoop: false,
              waveType: WaveType.liquidReveal,
              ignoreUserGestureWhileAnimating: true,
              onPageChangeCallback: pageChangeCallback,
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(3, _buildDots),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: FlatButton(
                  textColor: kPrimaryColor,
                  onPressed: () {
                    liquidController.animateToPage(page: 3 - 1, duration: 1000);
                  },
                  child: Text("Salta",style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),),
                  color: Colors.transparent,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: FlatButton(
                  textColor: kSecondaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                  child: Text("Login", style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),),
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
