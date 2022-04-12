import 'package:city_girls/providers/index.dart';

import './models/index.dart';
import 'package:flutter/material.dart';
import 'screens/index.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(

      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => ServiceProvider()),
            ChangeNotifierProvider(create: (_) => EmailProviders()),
            ChangeNotifierProvider(create: (_) => VideoProvider()),
            ChangeNotifierProvider(create: (_) => DocumentProvider()),
          ],child:MyApp()));
}

class MyApp extends StatelessWidget {
  Future<User> getUserData() => UserPreference().getUser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Roboto'),
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => Navigation(),
          '/login': (context) => Login(),
          '/create': (context) => CreateService(),
          '/profile': (context) => Profile(),
        },
        home: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else if (snapshot.data.accessToken == null ||
                      snapshot.data.accessToken == '')
                    return StartPage();
                  else {
                    return Navigation(
                      user: snapshot.data,
                    );
                  }
              }
            }),

    );
  }
}
