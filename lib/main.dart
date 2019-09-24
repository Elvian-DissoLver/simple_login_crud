import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/page/Admin/AdminPage.dart';
import 'package:simple_login_crud/page/Admin/EditUserPage.dart';
import 'package:simple_login_crud/page/Admin/UserListPage.dart';
import 'package:simple_login_crud/page/Auth/AuthPage.dart';
import 'package:simple_login_crud/scoped_models/app_model.dart';

void main() async {
  runApp(CRUD());
}

class CRUD extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CRUDState();
  }
}

class _CRUDState extends State<CRUD> {
  AppModel _model;
  bool _isAuthenticated = false;

  @override
  void initState() {

    _model = AppModel();
//    _model.loadSettings();
//    _model.autoAuthentication();
//
//    _model.userSubject.listen((bool isAuthenticated) {
//      setState(() {
//        _isAuthenticated = isAuthenticated;
//      });
//    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: _model,

      child: MaterialApp(
        title: 'CRUD',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (BuildContext context) =>
//          AuthPage(),
            AdminPage(_model),
          '/userPage': (BuildContext context) =>
          AuthPage(),
          '/editUser': (BuildContext context) =>
          EditUserPage(),
          '/listUser': (BuildContext context) =>
          UserListPage(_model),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) =>
                AuthPage(),
          );
        },
        builder: (BuildContext context, Widget child) {
          return new Padding(
              child: child,
              padding: const EdgeInsets.only(
                  bottom: 50.0
              )
          );
        },
      ),
    );
  }
}
