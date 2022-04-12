import 'package:city_girls/models/Service.dart';
import 'package:city_girls/screens/Inquiry.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';
import 'package:intl/intl.dart';

class ServiceDetail extends StatelessWidget {
  const ServiceDetail({@required Service this.service});
  final Service service;

  @override
  Widget build(BuildContext context) {
    // var format = DateFormat.yMd('ar');
    // var dateString = format.format(service.createdAt);
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(children: [
        Stack(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 200,
              width: SizeConfig.blockSizeHorizontal * 100,
              color: Colors.white,
            ),
            Positioned(
                child: Hero(
                    tag: service.id,
                    child: (service.logoUrl == null || service.logoUrl == "")
                        ? Image(
                            image: AssetImage('images/dummy.jpg'),
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            '${service.logoUrl}',
                            fit: BoxFit.cover,
                          ))),
            Positioned(
              top: SizeConfig.blockSizeVertical * 25,
              child: Container(
                height: SizeConfig.blockSizeVertical * 75,
                width: SizeConfig.blockSizeHorizontal * 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
              ),
            ),
            Positioned(
              top: SizeConfig.blockSizeVertical * 30,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 40),
                child: Text(
                  '${service.serviceName}' ?? "Unknown Service",
                  style: robotoBtnstyle,
                ),
              ),
            ),
            Positioned(
              left: SizeConfig.blockSizeHorizontal * 4,
              top: SizeConfig.blockSizeVertical * 35,
              child: Text(
                'About ' + service.serviceName,
                style: robotoBoldmdLabel,
              ),
            ),
            Positioned(
              top: SizeConfig.blockSizeVertical * 38,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 4),
                child: Text(
                  '${service.description}' ?? " ",
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                ),
              ),
            ),
            Positioned(
              top: SizeConfig.blockSizeVertical * 60,
              left: SizeConfig.blockSizeHorizontal * 35,
              child: Container(
                height: SizeConfig.blockSizeVertical * 8,
                width: SizeConfig.blockSizeVertical * 8,
                child: Card(
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.blockSizeVertical * 8),
                  ),
                  shadowColor: Colors.black,
                  child: ImageIcon(
                    AssetImage('images/locationicon.png'),
                    color: primary,
                    size: 32,
                  ),
                ),
              ),
            ),
            Positioned(
                top: SizeConfig.blockSizeVertical * 69,
                left: SizeConfig.blockSizeHorizontal * 35,
                child: Text(
                  "${service.location}",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
            // website is on
            Positioned(
                top: SizeConfig.blockSizeVertical * 75,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Website:',
                        style: robotoBtnstyle,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 10,
                      ),
                      Text(
                        '${service.websiteUrl}',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      )
                    ],
                  ),
                )),
            // phone
            Positioned(
                top: SizeConfig.blockSizeVertical * 80,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone:',
                        style: robotoBtnstyle,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 10,
                      ),
                      Text(
                        '${service.phoneNumber}',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      )
                    ],
                  ),
                )),
            //email
            Positioned(
                top: SizeConfig.blockSizeVertical * 85,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email us on:',
                        style: robotoBtnstyle,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 10,
                      ),
                      Text(
                        '${service.email}',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      )
                    ],
                  ),
                )),
            Positioned(
                top: SizeConfig.blockSizeVertical * 95,
                left: SizeConfig.blockSizeHorizontal * 2,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: Text(
                    'Follow us on:',
                    style: robotoBtnstyle,
                  ),
                )),
            Positioned(
                top: SizeConfig.blockSizeVertical * 100,
                left: SizeConfig.blockSizeHorizontal * 2,
                child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ImageIcon(
                          AssetImage('images/ig.png'),
                          color: primary,
                        ),
                        ImageIcon(
                          AssetImage('images/tw.png'),
                          color: primary,
                        ),
                      ],
                    ))),
            Positioned(
                top: SizeConfig.blockSizeVertical * 105,
                left: SizeConfig.blockSizeHorizontal * 2,
                child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${service.socialmedia[0]}' ?? ""),
                          Text('${service.socialmedia[0]}' ?? "")
                        ]))),

            Positioned(
                top: SizeConfig.blockSizeVertical * 110,
                left: SizeConfig.blockSizeHorizontal * 2,
                child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageIcon(
                            AssetImage('images/cart.png'),
                            color: primary,
                          ),
                          Text(
                            "Or shop with Us  ",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ]))),

// inquiry

            Positioned(
                top: SizeConfig.blockSizeVertical * 118,
                left: SizeConfig.blockSizeHorizontal * 20,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Inquiry()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: SizeConfig.blockSizeHorizontal * 60,
                      height: SizeConfig.blockSizeVertical * 6,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Text(
                        'Make an enquiry',
                        style: robotoBtnstyleWhite,
                      ),
                    ),
                  ),
                )),
          ],
        )
      ]),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              size: 32,
              color: Colors.black,
            )),
      ),
    );
  }
}
