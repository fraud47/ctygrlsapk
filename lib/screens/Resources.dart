import 'package:city_girls/models/Service.dart';
import 'package:city_girls/providers/DocumentProvider.dart';
import 'package:city_girls/providers/videoProvider.dart';
import 'package:city_girls/screens/DocumentBar.dart';
import 'package:city_girls/screens/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';
import '../providers/ServiceProvider.dart';
import 'package:provider/provider.dart';

class Resources extends StatefulWidget {
  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources>
    with SingleTickerProviderStateMixin {
  ScrollPhysics physics = const BouncingScrollPhysics();

  final ScrollController _scrollController = new ScrollController();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    VideoProvider videos = Provider.of<VideoProvider>(context);
    DocumentProvider docs = Provider.of<DocumentProvider>(context);

    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 6,
                  left: SizeConfig.blockSizeHorizontal * 4,
                  right: SizeConfig.blockSizeHorizontal * 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Resources",
                    style: robotoMdRegular,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                labelPadding:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
                unselectedLabelColor: Color(0xffE5E5E5),
                tabs: [
                  Tab(
                    child: Text('Videos',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18.0,
                        )),
                  ),
                  Tab(
                    child: Text('Tutorials',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18.0,
                        )),
                  ),
                  Tab(
                    child: Text('Documents',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18.0,
                        )),
                  )
                ]),
            Container(
                height: SizeConfig.blockSizeVertical * 90,
                child: TabBarView(
                    controller: _tabController,
                    key: PageStorageKey('scrollkey'),
                    children: [
                      RefreshIndicator(
                          onRefresh: () {
                            return videos.getVideos();
                          },
                          child: TabBarItem(name: "one", ey: 'key1')),
                      TabBarItem(name: "two", ey: 'key2'),
                      RefreshIndicator(
                          onRefresh: () {
                            return docs.getDocuments();
                          },
                          child: DocumentBarItem(name: "three", ey: 'key3')),
                    ]))
          ],
        ),
      ),
    );
  }
}
