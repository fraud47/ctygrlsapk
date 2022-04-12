import 'package:city_girls/models/index.dart';
import 'package:city_girls/models/user_prefference.dart';
import 'package:city_girls/providers/DocumentProvider.dart';
import 'package:city_girls/providers/UserProviders.dart';
import 'package:city_girls/providers/videoProvider.dart';
import 'package:flutter/material.dart';
import '../providers/ServiceProvider.dart';

import 'package:provider/provider.dart';
import '../config/index.dart';
import 'index.dart';

class Navigation extends StatefulWidget {
  const Navigation({User this.user});
  final User user;
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);

  int _index = 0;
  List<Widget> _pages = [
    NearbyStore(),
    Location(),
    Resources(),
    Profile(),
  ];
  set movePage(int index) {
    setState(() => _index = index);
    _pageController.jumpToPage(index);
  }

  set changeIndex(int index) {
    setState(() => _index = index);
  }

  int get currentPosition => _index;
  List<Widget> get pages => _pages;
  PageController get pageController => _pageController;

  @override
  void initState() {
    var serve = Provider.of<VideoProvider>(context, listen: false);
    serve.getVideos();
    var docs = Provider.of<DocumentProvider>(context, listen: false);
    var favs = Provider.of<ServiceProvider>(context, listen: false);
    favs.getFavourites();
    docs.getDocuments();
    if (widget.user == null) {
      _pages = [
        NearbyStore(),
        Location(),
        Resources(),
        Login(),
      ];
    } else {
      var of = Provider.of<UserProvider>(context, listen: false);
      of.setUser(widget.user);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _index == 1 ? primary : null,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (int newPage) {
            changeIndex = newPage;
          },
          children: _pages,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            color: Colors.white),
        child: SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              currentIndex: _index,
              onTap: (int index) => movePage = index,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              iconSize: 34,
              selectedItemColor: primary,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('images/homeicon.png')),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('images/locationicon.png')),
                    label: 'location'),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('images/shoppingicon.png')),
                    label: 'Shopping bag'),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('images/personicon.png')),
                    label: 'Person'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
