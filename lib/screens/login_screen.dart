import 'package:flutter/material.dart';
import 'package:tech_audit_app/bloc/navigator_bloc.dart';
import 'package:tech_audit_app/constants/constants.dart';

class LoginScreen extends StatelessWidget {
  static final routeName = "/login";
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - topPadding;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.only(top: topPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildHeader("Лайтинг Менеджмент Систем"),
                buildContent("Логин", "Пароль", "Войти"),
                buildFooter("Техаудит", "Версия: 1.0.1")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildHeader(String text) {
  return Container(
    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: ProjectColor.black, fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}

Widget buildContent(String login, String pass, String enter) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: login,
            prefixIcon: Icon(Icons.mail_rounded),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
              hintText: pass,
              prefixIcon: Icon(Icons.lock_rounded),
              suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye_rounded), onPressed: () {})),
          obscureText: true,
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              navigatorBloc.mapEventToState(NavigatorMainEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(enter),
            ))
      ],
    ),
  );
}

Widget buildFooter(String title, String subtitle) {
  return Container(
    padding: EdgeInsets.only(bottom: 10),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: ProjectColor.black,
              fontSize: 24,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 4,
        ),
        Text(subtitle)
      ],
    ),
  );
}
