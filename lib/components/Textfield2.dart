import 'package:flutter/material.dart';
import '../config/index.dart';

class Textfield2 extends StatefulWidget {
  const Textfield2({@required String this.label, bool this.maxLines = true});

  final String label;
  final bool maxLines;

  @override
  _Textfield2State createState() => _Textfield2State();
}

class _Textfield2State extends State<Textfield2> {
  var _label;
  int _maxLines = 3;

  bool complete = false;
  var focusNode = FocusNode();
  @override
  void initState() {
    _label = widget.label;

    focusNode.addListener(() {
      print(focusNode.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$_label',
            style: robotoBoldmdLabel,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 80,
            child: TextField(
              maxLines: _maxLines,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Name your service',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)))),
              onEditingComplete: () => {setState(() {})},
            ),
          )
        ],
      ),
    );
  }
}
