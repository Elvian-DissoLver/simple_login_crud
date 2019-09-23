import 'package:flutter/material.dart';
import 'package:simple_login_crud/widgets/ui_elements/rounded_button.dart';

class ConfirmDialog {
  static Future<bool> show(BuildContext context, [String title]) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title != null ? title : 'Are you sure to sign out?'),
          contentPadding: EdgeInsets.all(12.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RoundedButton(
                    label: 'No',
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: RoundedButton(
                    label: 'Yes',
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
