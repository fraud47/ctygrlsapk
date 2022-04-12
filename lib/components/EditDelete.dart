import 'package:flutter/material.dart';
import '../config/index.dart';

class EditDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        right: SizeConfig.blockSizeHorizontal * 10,
        left: SizeConfig.blockSizeHorizontal * 30,
        top: SizeConfig.blockSizeHorizontal * 1,
      ),
      child: Row(
        children: [
          ElevatedButton(
              onPressed: null,
              child: Text(
                'Save',
                style: robotoBoldmdLabel,
              )),
          TextButton(
              onPressed: null,
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.blockSizeVertical * 5,
                width: SizeConfig.blockSizeHorizontal * 20,
                child: Text(
                  'Delete',
                  style: robotoBoldmdLabelWhite,
                ),
                decoration: BoxDecoration(color: Color(0xffB60505)),
              ))
        ],
      ),
    );
  }
}
