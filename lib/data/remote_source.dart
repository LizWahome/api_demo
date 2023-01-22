import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

abstract class RemoteSources {
  Future<http.Response> post(Map<String, dynamic> body, String url);
  Future<http.Response> get(String url);
}

class RemoteSourseImpl implements RemoteSources {
  RemoteSourseImpl();
  @override
  Future<http.Response> post(Map<String, dynamic> body, String url) async {
    try {
      final res = await http.post(Uri.parse(url), body: body);
      return res;
    } on SocketException {
      toast('Please connect to internet', bgColor: errorColor);
      throw ('Please connect to internet');
    } catch (e) {
      throw ('$e');
    }
  }
  
  @override
  Future<http.Response> get(String url) async{
   try {
      final res = await http.get(Uri.parse(url));
      return res;
    } on SocketException {
      toast('Please connect to internet', bgColor: errorColor);
      throw ('Please connect to internet');
    } catch (e) {
      throw ('$e');
    }
  }
}
