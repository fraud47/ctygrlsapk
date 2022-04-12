import 'package:city_girls/components/Profiledisplay.dart';
import 'package:city_girls/models/index.dart';
import 'package:city_girls/screens/CreateService.dart';
import 'package:city_girls/screens/favourites.dart';
import 'package:city_girls/screens/index.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';
import '../controllers/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);
    UserProvider user = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: ClipRRect(
              child: ProfilePicture(
                name: '${user.user.fullname}' + '${user.user.surname}',
                radius: 31,
                fontsize: 21,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                '${user.user.fullname} ' + '${user.user.surname}',
                style: primaryHeadingMd,
              ),
              Text(
                '',
                style: roboto18Black,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Favourites()));
            },
            child: ProfileDisplay(
                icon: Icon(
                  Icons.favorite,
                  size: 46,
                ),
                desc: 'Favourites'),
          ),
          !(user.user.service)
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateService()));
                  },
                  child: ProfileDisplay(
                      icon: Icon(Icons.add), desc: 'add service'))
              : InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReadService()));
                  },
                  child: ProfileDisplay(
                      icon: Icon(Icons.add), desc: 'edit service')),
          InkWell(
            onTap: () {
              UserPreference().removeUser();
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: ProfileDisplay(
                icon: Icon(
                  Icons.logout,
                  size: 46,
                ),
                desc: 'Sign Out'),
          ),
        ],
      ),
    );
  }
}
