import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/scoped_models/app_model.dart';
import 'package:simple_login_crud/widgets/helpers/confirm_dialog.dart';

class AppDrawer extends StatefulWidget {
  final AppModel model;

  AppDrawer(this.model);

  @override
  State<StatefulWidget> createState() {
    return _AppDrawerState();
  }
}


class _AppDrawerState extends State<AppDrawer> {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {
          return Drawer(
              elevation: 20.0,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(model.user.username),
                    currentAccountPicture: new CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text(model.user.username[0].toUpperCase())
                    ),

                    decoration: BoxDecoration(
                        color: Colors.blue
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Edit Account'),
                    onTap: () {
                      model.setEditUser(widget.model.currentUser);
                      Navigator.pushNamed(context, '/editUser');
                    },
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Sign out'),
                    onTap: () async{
                      bool confirm = await ConfirmDialog.show(context);

                      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

                      if (confirm) {
                        model.signOut();
                      }
                    },
                  )
                ],
              ));
        }
    );
  }
}