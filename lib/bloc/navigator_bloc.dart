import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tech_audit_app/screens/error_screen.dart';
import 'package:tech_audit_app/screens/main_screen.dart';
import 'package:tech_audit_app/screens/photo_view_screen.dart';
import 'package:tech_audit_app/screens/point_details_screen.dart';
import 'package:tech_audit_app/screens/video_view_screen.dart';

//events
abstract class NavigatorEvents {}

class NavigatorInitialEvent extends NavigatorEvents {
  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorInitialEvent({this.navigatorKey});
}

class NavigatorErrorEvent extends NavigatorEvents {}

class NavigatorPopEvent extends NavigatorEvents {}

class NavigatorMainEvent extends NavigatorEvents {}

class NavigatorDetailsEvent extends NavigatorEvents {}

class NavigatorPhotoViewEvent extends NavigatorEvents {}

class NavigatorVideoViewEvent extends NavigatorEvents {}

//states
abstract class NavigatorStates {}

class NavigatorLogin extends NavigatorStates {}

class NavigatorMain extends NavigatorStates {}

class NavigatorBloc {
  BehaviorSubject<NavigatorStates> _subject = BehaviorSubject();
  BehaviorSubject<NavigatorStates> get subject => _subject;
  GlobalKey<NavigatorState> navigatorKey;

  void mapEventToState(NavigatorEvents event) {
    switch (event.runtimeType) {
      case NavigatorInitialEvent:
        //check if the user logged in before
        NavigatorInitialEvent initialEvent = event;
        navigatorKey = initialEvent.navigatorKey;
        _subject.sink.add(NavigatorLogin());
        break;
      case NavigatorErrorEvent:
        navigatorKey.currentState.pushNamed(ErrorScreen.routeName);
        break;
      case NavigatorPopEvent:
        navigatorKey.currentState.pop();
        print("yeah nigga im popped");
        break;
      case NavigatorMainEvent:
        navigatorKey.currentState.pushReplacementNamed(MainScreen.routeName);
        break;
      case NavigatorDetailsEvent:
        navigatorKey.currentState.pushNamed(PointDetailsScreen.routeName);
        break;
      case NavigatorPhotoViewEvent:
        navigatorKey.currentState.pushNamed(PhotoViewScreen.routeName);
        break;
      case NavigatorVideoViewEvent:
        navigatorKey.currentState.pushNamed(VideoViewScreen.routeName);
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final navigatorBloc = NavigatorBloc();
