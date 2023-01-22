import 'dart:convert';

import 'package:api_demo/data/remote_source.dart';
import 'package:api_demo/data/utils/urls.dart';

Future<Map<String, dynamic>> getListOfUsers(page) async {
  final impl = RemoteSourseImpl();

  var res = await impl.get(ListOfUsersUrl(page));
  return jsonDecode(res.body);
}
