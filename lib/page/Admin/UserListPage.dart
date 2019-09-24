import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/scoped_models/app_model.dart';
import 'package:simple_login_crud/widgets/ui_elements/loading_modal.dart';
import 'package:simple_login_crud/widgets/user/UserListView.dart';

class UserListPage extends StatefulWidget {
  final AppModel model;

  UserListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _UserListPageState();
  }
}

class _UserListPageState extends State<UserListPage> {

  @override
  void initState() {

    widget.model.fetchUsers();

    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'CRUD',
      ),
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: UserListView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack stack = Stack(
          children: <Widget>[
            _buildPageContent(model),
          ],
        );

        if (model.isLoading) {
          stack.children.add(LoadingModal());
        }

        return stack;
      },
    );
  }
}

