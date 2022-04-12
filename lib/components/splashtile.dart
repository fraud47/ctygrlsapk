import 'package:flutter/material.dart';
import '../config/index.dart';

class SplashTile extends StatelessWidget {
  const SplashTile({@required String this.heading, @required String this.body});
  final String heading;
  final String body;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image(
          image: AssetImage('images/vectorSplash.png'),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal * 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: robotoHeadingBlackBold,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Text(
                body,
                style: robotoSmBlack,
              )
            ],
          ),
        )
      ],
    );
  }
}
