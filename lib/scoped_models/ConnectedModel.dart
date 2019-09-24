
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_login_crud/models/user.dart';

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

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }

  }

  Future<bool> createUser(
      User newUser) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> formData = {
      'username': newUser.username,
      'password': newUser.password,
      'date': DateTime.now().toIso8601String(),
    };
    String id;
    try {

      return true;
    }  catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
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

  Future<bool> removeUser(String id) async {
    _isLoading = true;
    notifyListeners();

    try {

      int noteIndex = _users.indexWhere((t) => t.id == id);
      _users.removeAt(noteIndex);


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