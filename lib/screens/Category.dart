import 'package:city_girls/components/CardItem.dart';
import 'package:city_girls/controllers/ServiceController.dart';

import 'package:flutter/material.dart';
import '../config/index.dart';
import '../providers/ServiceProvider.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  const Category({@required this.category = 'Services'});
  final String category;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          strokeWidth: SizeConfig.blockSizeHorizontal * 2,
          color: Color(0xffE36A6A),
        )
      ],
    );

    ServiceProvider services = Provider.of<ServiceProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.category,
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: ServiceController.getCategory('${widget.category}'),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: loading);
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else if (snapshot.data == null) {
                  return Center(
                    child: Text(
                      "no services",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  );
                } else {
                  var data = snapshot.data;
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
    );
  }
}
               
      
      
      
      
      
      
      
      

      
      
 
      
      
      
      
      
      
      
      
      
      
      
   

    // var service = Provider.of<ServiceProvider>(context, listen: false);
    // service.setCategoryServices(serviceController.getCategory(widget.category));