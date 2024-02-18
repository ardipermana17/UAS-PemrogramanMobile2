import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<bool> checkSession(String sessionToken) async {
    final Dio _dio = Dio();

    try {
      //source check session disini
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String sessionToken = prefs.getString('session') ?? "";
      Map fdataMap = {'session_token': sessionToken};
      FormData fdata = FormData();
      fdata.fields
          .addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));
      final response = await _dio.post(
        'https://thriftstore1.000webhostapp.com/session.php',
        data: fdata,
      );

      log("check session $response");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.data);
        return data['status'] == 'success';
      }
    } catch (error) {
      // Handle error if needed
    }
    return false;
  }

  Future logout() async {
    final Dio _dio = Dio();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('session') ?? "";
    Map fdataMap = {'session_token': sessionToken};
    FormData fdata = FormData();
    fdata.fields.addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));
    final response = await _dio.post(
      'https://thriftstore1.000webhostapp.com/logout.php',
      data: fdata,
    );
    prefs.remove('session_token');
  }

  Future login({required String username, required String password}) async {
    final Dio _dio = Dio();
    Map fdataMap = {'user': username, 'pwd': password};
    FormData fdata = FormData();
    fdata.fields.addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));

    final response = await _dio.post(
      'https://thriftstore1.000webhostapp.com/login.php',
      data: fdata,
    );
    log("res $response");
    Map repoResponse = {"status": false, "data": Null};
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.data);
      if (data['status'] == 'success') {
        repoResponse['status'] = true;
        repoResponse['data'] = data;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('session', data['session_token']);
      } else {
        repoResponse['data'] = data;
      }
    }
    return repoResponse;
  }

  Future addRegister({
    required String username,
    required String password,
    required String name,
  }) async {
    final Dio _dio = Dio();
    try {
      FormData formData = FormData.fromMap({
        'user': username,
        'pwd': password,
        'name': name,
      });

      Response response = await _dio.post(
        'https://thriftstore1.000webhostapp.com/register.php',
        data: formData,
      );

      log(response.data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to add user');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
