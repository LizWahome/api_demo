import 'dart:convert';

import 'package:api_demo/data/remote_source.dart';
import 'package:api_demo/data/utils/extentions.dart';
import 'package:api_demo/data/utils/urls.dart';
import 'package:api_demo/repository/model/login/login_succes.dart';
import 'package:api_demo/repository/model/login_error.dart';
import 'package:either_dart/either.dart';

Future<Either<LoginSucces, LoginError>> doLogin(
    Map<String, dynamic> body) async {
  RemoteSourseImpl impl = RemoteSourseImpl();

  final res = await impl.post(body, loginUrl);
  if (res.ok) {
    return Left(LoginSucces.fromJson(jsonDecode(res.body)));
  } else {
    return Right(LoginError.fromJson(jsonDecode(res.body)));
  }
}
