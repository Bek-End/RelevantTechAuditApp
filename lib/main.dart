import 'package:flutter/material.dart';
import 'package:tech_audit_app/bloc/navigator_bloc.dart';
import 'package:tech_audit_app/screens/camera/camera.dart';
import 'package:tech_audit_app/screens/error_screen.dart';
import 'package:tech_audit_app/screens/login_screen.dart';
import 'package:tech_audit_app/screens/main_screen.dart';
import 'package:tech_audit_app/screens/photo_view_screen.dart';
import 'package:tech_audit_app/screens/point_details_screen.dart';
import 'package:tech_audit_app/screens/video_view_screen.dart';

void main() {
  runApp(App());
}

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

class App extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    imageCache.clear();
    super.initState();
    navigatorBloc
        .mapEventToState(NavigatorInitialEvent(navigatorKey: _navigatorKey));
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = true;
    return StreamBuilder(
        stream: navigatorBloc.subject.stream,
        builder: (context, AsyncSnapshot<NavigatorStates> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.runtimeType) {
              case NavigatorLogin:
                isLoggedIn = false;
                break;
            }
            return MaterialApp(
              title: 'Tech Audit App',
              navigatorKey: _navigatorKey,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              routes: {
                LoginScreen.routeName: (context) => LoginScreen(),
                ErrorScreen.routeName: (context) => ErrorScreen(),
                MainScreen.routeName: (context) => MainScreen(),
                PointDetailsScreen.routeName: (context) => PointDetailsScreen(),
                PhotoViewScreen.routeName: (context) => PhotoViewScreen(),
                VideoViewScreen.routeName: (context) => VideoViewScreen(),
                CameraScreen.routeName: (context) => CameraScreen()
              },
              home: isLoggedIn ? ErrorScreen() : LoginScreen(),
            );
          } else {
            return MaterialApp(
              home: Container(),
            );
          }
        });
  }
}
