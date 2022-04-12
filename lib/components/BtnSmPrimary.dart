import 'package:flutter/material.dart';
import '../config/index.dart';

class BtnSmPrimary extends StatelessWidget {
  const BtnSmPrimary({@required String this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 45,
      height: SizeConfig.blockSizeVertical * 6,
      decoration: BoxDecoration(
          color: primary,
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5)),
      child: TextButton(
        child: Text(
          name,
          style: robotoBoldmdLabelWhite,
        ),
        onPressed: null,
      ),
    );
  }
}
