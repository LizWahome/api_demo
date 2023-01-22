import 'package:api_demo/repository/model/users/list_of_users.dart';

const loginUrl = "https://reqres.in/api/login";
ListOfUsersUrl(int page) => "https://reqres.in/api/users?page=$page";
