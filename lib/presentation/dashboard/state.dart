import 'package:api_demo/repository/model/users/list_of_users.dart';
import 'package:api_demo/repository/use_case/list_of_users_usecase.dart';
import 'package:flutter/cupertino.dart';

class DashboardProvider extends ChangeNotifier {
  int _users = -1;
  int get users => _users;

  ListOfUsers? _listOfUsers;
  ListOfUsers? get listOfUsers => _listOfUsers;

  Future<void> reqListOfUsers(int page) async {
    _users = -1;
    _listOfUsers = null;

    final res = await getListOfUsers(page);

    _users = res.length;
    _listOfUsers = ListOfUsers.fromJson(res);

    notifyListeners();
  }
}
