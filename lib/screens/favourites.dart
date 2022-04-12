import 'package:city_girls/components/CardItem.dart';
import 'package:city_girls/config/index.dart';
import 'package:city_girls/providers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites();

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    ServiceProvider favourite = Provider.of<ServiceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(Icons.arrow_back, color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        title: Text('Favourites'),
        titleTextStyle: robotoBtnstyle,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return CardItem(
            service: favourite.favourites[index],
          );
        },
        itemCount: favourite.favourites.length,
      ),
    );
  }
}
