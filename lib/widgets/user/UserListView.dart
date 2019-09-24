import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/models/user.dart';
import 'package:simple_login_crud/scoped_models/app_model.dart';

import 'UserCard.dart';

class UserListView extends StatelessWidget {

  Widget _buildEmptyText(AppModel model) {
    String emptyText;

    emptyText = 'There is no user here. \r\nCreate a new user.';

    return Container(
      color: Color.fromARGB(16, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Text(
            emptyText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(AppModel model) {
    return ListView.builder(
      itemCount: model.users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = model.users[index];

        return Dismissible(
          key: Key(user.id),
          onDismissed: (DismissDirection direction) {
            model.removeUser(user.id);
          },
          child: UserCard(user),
          background: Container(color: Colors.red),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Widget noteCards = model.users.length > 0
            ? _buildListView(model)
            : _buildEmptyText(model);

        return noteCards;
      },
    );
  }
}