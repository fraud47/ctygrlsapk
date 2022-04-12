import 'package:flutter/material.dart';
import '../config/index.dart';

class ProfileDisplay extends StatelessWidget {
  const ProfileDisplay({@required Icon this.icon, @required String this.desc});

  final Icon icon;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          icon,
          desc == 'Sign Out'
              ? Text(
                  'Sign Out',
                  style: robotoSmBlueUnderline,
                )
              : Text(
                  desc,
                  style: roboto18Black,
                )
        ],
      ),
    );
  }
}
