import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/scoped_models/ConnectedModel.dart';

class AppModel extends Model with CoreModel, UsersModel, Auth {}
