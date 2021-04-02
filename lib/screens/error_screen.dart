import 'package:flutter/material.dart';
import 'package:tech_audit_app/bloc/navigator_bloc.dart';
import 'package:tech_audit_app/constants/constants.dart';

class ErrorScreen extends StatelessWidget {
  static final routeName = "/errorScreen";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("popped");
        navigatorBloc.mapEventToState(NavigatorPopEvent());
      },
      child: Scaffold(
        body: Center(
          child: Text(
            "Oops, something went wrong:(",
            style: TextStyle(
                color: ProjectColor.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
