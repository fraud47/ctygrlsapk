import 'package:city_girls/screens/index.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';
import '../components/index.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 8),
            child: Text(
              'CITYGIRLS_zw',
              style: whiteheadingLg,
            ),
          ),
          ClipRect(
            child: Container(
              child: Image(
                height: SizeConfig.blockSizeVertical * 25,
                width: SizeConfig.blockSizeVertical * 25,
                image: AssetImage('images/logo1.jpeg'),
              ),
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 80,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 6),
            child: Text(
              'For the young woman on the move',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32, fontFamily: 'Oleo Script', color: Colors.white),
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              )
            },
            child: accessBtn(
              name: 'Sign Up',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 1),
            child: Text(
              'Or',
              style: whiteheadingSm,
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: accessBtn(name: 'Log in'))
        ],
      )),
      backgroundColor: primary,
    );
  }
}
