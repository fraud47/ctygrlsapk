import 'package:city_girls/screens/Category.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';
import '../controllers/index.dart';
import 'package:provider/provider.dart';

import 'Resources.dart';

class NearbyStore extends StatefulWidget {
  @override
  State<NearbyStore> createState() => _NearbyStoreState();
}

class _NearbyStoreState extends State<NearbyStore> {
  var categories = [
    {'name': 'Fashion', 'img': 'images/cartFashion.png', 'color': primary},
    {
      'name': 'Beauty',
      'img': 'images/cartBeauty.png',
      'color': Color(0xff1C1CBB).withOpacity(0.7)
    },
    {'name': 'Food', 'img': 'images/cartFood.png', 'color': Color(0xff355E7E)},
    {
      'name': 'Travel',
      'img': 'images/cartTravel.png',
      'color': Color(0xffBC85FC)
    },
    {
      'name': 'Lifestyle',
      'img': 'images/cartLifestyle.png',
      'color': Color(0xff437A03)
    },
    {
      'name': 'Health',
      'img': 'images/cartHealth.png',
      'color': Color(0xffF48380)
    },
    {
      'name': 'Design',
      'img': 'images/cartDesign.png',
      'color': Color(0xff863F14)
    },
    {
      'name': 'Entertainment',
      'img': 'images/cartEntertainment.png',
      'color': Color(0xffE3E344)
    },
    {
      'name': 'Money',
      'img': 'images/cartMoney.png',
      'color': Color(0xff808080)
    },
  ];

  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    UserProvider user = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 5,
                left: SizeConfig.blockSizeHorizontal * 5),
            child: Text(
              'How are you?.',
              style: TextStyle(fontSize: 28, color: Colors.black54),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 0.3,
                left: SizeConfig.blockSizeHorizontal * 6),
            child: Text(
              "${user.user.fullname ?? "Little Girl"}",
              style: TextStyle(
                  fontSize: 38,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 3,
                horizontal: SizeConfig.blockSizeHorizontal * 5),
            child: Text(
              'Find products and services near you',
              textAlign: TextAlign.center,
              style: robotoBtnstyle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
            child: Text(
              "Categories",
              style: TextStyle(
                  fontSize: 30, color: primary, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 4,
          ),
          Expanded(
            child: GridView.count(
              controller: _controller,
              crossAxisCount: 2,
              mainAxisSpacing: SizeConfig.blockSizeVertical * 1,
              crossAxisSpacing: 1,
              children: List.generate(9, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  category: categories[index]['name'],
                                )));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 4,
                      width: SizeConfig.blockSizeHorizontal * 3,
                      decoration: BoxDecoration(
                          color: primary.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(
                              SizeConfig.blockSizeHorizontal * 4))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: categories[index]['color'],
                                  width: SizeConfig.blockSizeHorizontal * 2),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  SizeConfig.blockSizeHorizontal * 20)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  SizeConfig.blockSizeHorizontal * 20)),
                              child: Image(
                                image:
                                    AssetImage('${categories[index]['img']}'),
                                height: SizeConfig.blockSizeHorizontal * 20,
                                width: SizeConfig.blockSizeHorizontal * 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            categories[index]['name'],
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
