import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/scoped_models/app_model.dart';
import 'package:simple_login_crud/widgets/helpers/MessageDialog.dart';
import 'package:simple_login_crud/widgets/style/theme.dart' as Theme;
import 'package:simple_login_crud/widgets/ui_elements/loading_modal.dart';
import 'package:simple_login_crud/widgets/ui_elements/rounded_button.dart';

class AuthPage extends StatefulWidget {
@override
State<StatefulWidget> createState() {
  return _AuthPageState();
}
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _authenticate(AppModel model) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    Map<String, dynamic> authResult;
//    await model.signInWithEmailAndPassword(_formData['email'], _formData['password']);

    if (authResult['success']) {
    } else {
      MessageDialog.show(context, message: authResult['message']);
    }
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter password';
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
          icon: Icon(Icons.edit),
          label: 'Sign up',
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
        ),
        SizedBox(
          width: 20.0,
        ),
        RoundedButton(
          icon: Icon(Icons.lock_open),
          label: 'Sign in',
          onPressed: () => _authenticate(model),
        ),
      ],
    );
  }

  Widget _logoApp() {
    return Container(
      child: Center(
        child: new Text(
            'CRUD',
          style: TextStyle(
            fontSize: 20,
          ),
        )
      ),
    );
  }

  Widget _buildPageContent(AppModel model) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.85;

    return Scaffold(
      backgroundColor: Colors.yellow,
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
                    _logoApp(),
                    SizedBox(
                      height: 70.0,
                    ),
                    _buildEmailField(),
                    _buildPasswordField(),
                    SizedBox(
                      height: 70.0,
                    ),
                    _buildButtonRow(model)
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
