
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/models/User.dart';
import 'package:simple_login_crud/services/database.dart';

mixin CoreModel on Model {
  List<User> _users = [];
  User _user;
  bool _isLoading = false;

}

mixin UsersModel on CoreModel {
  List<User> get users {
    return List.from(_users);
  }

  bool get isLoading {
    return _isLoading;
  }

  User get currentUser {
    return _user;
  }

  void setCurrentNote(User user) {
    _user = user;
  }

  Future<Null> fetchUsers() async{
    _isLoading = true;
    notifyListeners();

    _users = [];

    print('fetch note');

    try {

      var fetchedUsers = await UsersDatabaseService.db.getUsersFromDB();
      print('list');
      print(fetchedUsers);
      _users= fetchedUsers;

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }

  }

  Future<Map<String, dynamic>> createUser(
      User newUser) async {
    _isLoading = true;
    notifyListeners();

    String id;

    try {
      print('--------');
      await UsersDatabaseService.db.addUserInDB(newUser);

      _isLoading = false;
      notifyListeners();

      return {'success': true};
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': error.toString()};
    }
  }

  Future<bool> updateUser(
      User newUser) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> formData = {
      'username': newUser.username,
      'password': newUser.password,
      'date': DateTime.now().toIso8601String(),
    };

    try {

      _isLoading = false;
      notifyListeners();

      return true;
    }  catch (error) {
      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

  Future<bool> removeUser(User currentUser) async {
    _isLoading = true;
    notifyListeners();

    try {

      int noteIndex = _users.indexWhere((t) => t.id == currentUser.id);
      _users.removeAt(noteIndex);

      await UsersDatabaseService.db.deleteUserInDB(currentUser);

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      return false;
    }
  }
}