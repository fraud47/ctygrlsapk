import 'package:city_girls/components/textfield.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';
import '../components/index.dart';

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 8,
                  bottom: SizeConfig.blockSizeVertical * 10),
              child: Text(
                "Welcome to city girls App",
                style: robotoBtnstyle,
              ),
            ),
            SplashTile(
                heading: 'Create and manage your account',
                body:
                    'An account here represents \nyour organisation.  It is the entity \nthat will be billed for any services \nyou purchase from Fresh Idea'),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 6,
            ),
            SplashTile(
                heading: 'Set up services',
                body:
                    'An account here represents \nyour organisation.  It is the entity \nthat will be billed for any services \nyou purchase from Fresh Idea'),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 6,
            ),
            SplashTile(
                heading: 'Easily execute your admin task',
                body:
                    'An account here represents \nyour organisation.  It is the entity \nthat will be billed for any services \nyou purchase from Fresh Idea'),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 10,
            ),
            Container(
              alignment: Alignment.center,
              width: SizeConfig.blockSizeHorizontal * 80,
              height: SizeConfig.blockSizeVertical * 8,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Text(
                'Create Account',
                style: robotoBtnstyleWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
