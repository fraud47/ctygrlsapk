import 'package:flutter/material.dart';
import '../config/index.dart';
import '../components/index.dart';

class UserOwner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 8,
                bottom: SizeConfig.blockSizeVertical * 10),
            child: Text(
              'Login',
              style: whiteheadingSm,
            ),
          ),
          ClipRect(
            child: Container(
              child: Image(
                image: AssetImage('images/Rectangle28.png'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 8,
                bottom: SizeConfig.blockSizeVertical * 6),
            child: Text('as', style: whiteheadingSm),
          ),
          accessBtn(
            name: 'Customer',
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 4),
            child: Text(
              'Or',
              style: whiteheadingSm,
            ),
          ),
          accessBtn(name: 'Business Owner')
        ],
      )),
      backgroundColor: primary,
    );
  }
}
