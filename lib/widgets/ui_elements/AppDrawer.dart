//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';;
//import 'package:scoped_model/scoped_model.dart';
//import 'package:simple_login_crud/scoped_models/app_model.dart';
//import 'package:simple_login_crud/widgets/helpers/confirm_dialog.dart';
//
//class AppDrawer extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return ScopedModelDescendant<AppModel>(
//        builder: (BuildContext context, Widget child, AppModel model) {
//          return Drawer(
//              elevation: 20.0,
//              child: ListView(
//                padding: EdgeInsets.zero,
//                children: <Widget>[
//                  UserAccountsDrawerHeader(
//                    accountName: Text(model.user.displayName),
//                    accountEmail: Text(model.user.email),
//                    currentAccountPicture: new CircleAvatar(
//                      backgroundColor: Colors.blue,
//                      child: model.user.photoURL == null ? Text(model.user.displayName[0]) : Image.network(model.user.photoURL)
//                    ),
//                    otherAccountsPictures: <Widget> [
//                       Text(
//                        Configure.AppName,
//                        style: TextStyle(
//                            color: Color(0xFF005bea),
//                            fontSize: 11
//                        ),
//                       )
//                    ],
//
//                    decoration: BoxDecoration(
////                        color: Colors.yellow
//                        color: model.settings.isDarkThemeUsed? Colors.black38 : Colors.yellow
//                    ),
//                  ),
//
//                  ListTile(
//                    leading: new Image.asset(
//                      'assets/img/icon-note.png',
//                      width: 30,
//                      height: 30,
//                    ),
//                    title: Text('My Note'),
//                    onTap: () {
//                      // This line code will close drawer programatically....
////                      Navigator.pop(context);
//                      Navigator.pushNamed(context, '/');
//                    },
//                  ),
//                  Divider(
//                    height: 2.0,
//                  ),
//                  ListTile(
//                    leading: new Image.asset(
//                      'assets/img/icon-todo-list.png',
//                      width: 30,
//                      height: 30,
//                      ),
//                    title: Text('Todo List'),
//                    onTap: () {
//                      Navigator.pushNamed(context, '/listTodo');
//                    },
//                  ),
//                  Divider(
//                    height: 2.0,
//                  ),
//                  ListTile(
//                    leading: Icon(Icons.settings),
//                    title: Text('Setting'),
//                    onTap: () {
//                      Navigator.pushNamed(context, '/settings');
//                    },
//                  ),
//                  Divider(
//                    height: 2.0,
//                  ),
//                  ListTile(
//                    leading: Icon(Icons.exit_to_app),
//                    title: Text('Sign out'),
//                    onTap: () async{
//                      bool confirm = await ConfirmDialog.show(context);
//
//                      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
//
//                      if (confirm) {
//                        model.signOut();
//                      }
//                    },
//                  )
//                ],
//              ));
//        }
//    );
//  }
//}