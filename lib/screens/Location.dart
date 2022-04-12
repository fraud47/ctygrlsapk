import 'package:city_girls/controllers/ServiceController.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';
import '../components/index.dart';
import 'package:flutter/cupertino.dart';

class Location extends StatefulWidget {
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String dropdownValue = 'Harare';
  @override
  Widget build(BuildContext context) {
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          strokeWidth: SizeConfig.blockSizeHorizontal * 2,
          color: Color(0xffE36A6A),
        )
      ],
    );

    SizeConfig().init(context);
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 1),
            child: Text(
              'CITYGIRLS_zw',
              style: whiteheadingLg,
            ),
          ),
          Center(
            child: Container(
              height: SizeConfig.blockSizeVertical * 6,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 4,
                  vertical: SizeConfig.blockSizeVertical * 1),
              color: Color(0xffE5E5E5),
              child: Theme(
                  data: ThemeData(
                    primaryColor: Color(0xffE1E1E1),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    menuMaxHeight: SizeConfig.blockSizeHorizontal * 60,
                    hint: Text(
                      "Choose your location",
                      style: robotoMdRegular,
                    ),
                    dropdownColor: Color(0xffE1E1E1),
                    focusColor: Colors.black54,
                    elevation: 6,
                    icon: ImageIcon(
                      AssetImage('images/locationicon.png'),
                      color: primary,
                    ),
                    underline: SizedBox(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Harare', 'Mutare', 'Norton']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: roboto18Black,
                        ),
                      );
                    }).toList(),
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: ServiceController.getLocation(dropdownValue),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return loading;
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else if (snapshot.data == null)
                        return Center(
                          child: Text(
                            "no services",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        );
                      else {
                        var data = snapshot.data;
                        print(data);
                        var length;
                        length = data.length;

                        return Center(
                            child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return CardItem(
                              service: data[index],
                            );
                          },
                          itemCount: length,
                        ));
                      }
                  }
                }),
          )
        ],
      )),
      backgroundColor: primary,
    );
  }
}
