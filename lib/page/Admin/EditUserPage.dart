import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/scoped_models/app_model.dart';
import 'package:simple_login_crud/widgets/helpers/MessageDialog.dart';
import 'package:simple_login_crud/widgets/style/theme.dart' as Theme;
import 'package:simple_login_crud/widgets/ui_elements/rounded_button.dart';

class EditUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditUserPageState();
  }
}

class _EditUserPageState extends State<EditUserPage> {
  final Map<String, dynamic> _formData = {
    'username': null,
    'password': null,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  void _register(AppModel model) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    Map<String, dynamic> authResult;
//    await model.createUserWithEmailAndPassword(_formData['email'], _formData['password']);

    if (authResult['success']) {
      Navigator.pop(context);
    } else {
      MessageDialog.show(context, message: authResult['message']);
    }
  }

  Widget _buildUserNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Username'),
      validator: (value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid username';
        }
      },
      onSaved: (value) {
        _formData['username'] = value;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Confirm Password'),
      validator: (value) {
        if (value != _passwordController.value.text) {
          return 'Password and confirm password are not match';
        }
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      controller: _passwordController,
      validator: (value) {
        if (value.isEmpty || value.length < 6) {
          return 'Please enter valid password';
        }
      },
      onSaved: (value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildButtonRow(AppModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RoundedButton(
          icon: Icon(Icons.add_circle),
          label: 'Add User',
          onPressed: () {
            _register(model);
          },
        ),
      ],
    );
  }

  Widget _buildPageContent(AppModel model) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.85;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRUD'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height >= 775.0
            ? MediaQuery.of(context).size.height
            : 775.0,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Theme.Colors.loginGradientStart,
                Theme.Colors.loginGradientEnd
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildUserNameField(),
                    _buildPasswordField(),
                    _buildConfirmPasswordField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildButtonRow(model),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack mainStack = Stack(
          children: <Widget>[
            _buildPageContent(model),
          ],
        );

//        if (model.isLoading) {
//          mainStack.children.add(LoadingModal());
//        }

        return mainStack;
      },
    );
  }
}


