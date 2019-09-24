import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/models/User.dart';
import 'package:simple_login_crud/scoped_models/app_model.dart';

List<Color> colorList = [
  Colors.blue,
  Colors.green,
  Colors.indigo,
  Colors.red,
  Colors.cyan,
  Colors.teal,
  Colors.amber.shade900,
  Colors.deepOrange
];

class UserCard extends StatelessWidget {

  UserCard(this.userData);

  final User userData;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {
          String neatDate = DateFormat.yMd().add_jm().format(userData.date);
          Color color = colorList.elementAt(
              userData.username.length % colorList.length);
          return Container(
              margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [buildBoxShadow(color, context)],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                color: Colors.purple,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    model.setCurrentNote(userData);
                    Navigator.pushNamed(context, '/editorNote');
                  },
                  splashColor: color.withAlpha(20),
                  highlightColor: color.withAlpha(10),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${userData.username
                              .trim()
                              .length <= 20 ? userData.username.trim() : userData
                              .username.trim().substring(0, 20) + '...'}',
                          style: TextStyle(
                              fontFamily: 'ZillaSlab',
                              fontSize: 20,
                              color: Colors.black
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            '${userData.id.toString()
                                .trim()
                                .split('\n')
                                .first
                                .length <= 30 ? userData.id.toString()
                                .trim()
                                .split('\n')
                                .first : userData.id.toString()
                                .trim()
                                .split('\n')
                                .first
                                .substring(0, 30) + '...'}',
                            style:
                            TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 14),
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: <Widget>[
                              Spacer(),
                              Text(
                                'Last Edit: $neatDate',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        }
    );
  }

  BoxShadow buildBoxShadow(Color color, BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return BoxShadow(

          blurRadius: 8,
          offset: Offset(0, 8));
    }
    return BoxShadow(

        blurRadius: 8,
        offset: Offset(0, 8));
  }
}

class AddNoteCardComponent extends StatelessWidget {
  const AddNoteCardComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
        height: 110,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Add new note',
                            style: TextStyle(
                                fontFamily: 'ZillaSlab',
                                color: Theme.of(context).primaryColor,
                                fontSize: 20),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

}
