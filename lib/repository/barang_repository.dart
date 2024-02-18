import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class BarangRepository {
  final Dio _dio = Dio();

  Future addBarang(
      {required String nama,
      required String merk,
      required String harga,
      required String stok,
      required String date,
      required File image}) async {
    try {
      String fileName = basename(image.path).split('/').last;
      ;
      FormData formData = FormData.fromMap({
        'nama': nama,
        'merk': merk,
        'harga': harga,
        'stok': stok,
        'tanggal': date,
        'url_image':
            await MultipartFile.fromFile(image.path, filename: fileName),
      });

      Response response = await _dio.post(
        'https://thriftstore1.000webhostapp.com/add_barang.php',
        data: formData,
      );

      log(response.data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to add barang');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future getBarangList(keyword) async {
    try {
      log("GETTING BARANG");
      var response = await _dio.get(
        'https://thriftstore1.000webhostapp.com/list_barang.php',
        queryParameters: {'key': keyword},
      );
      log("list $response");

      if (response.statusCode == 200) {
        log("MASUK KONDISI IF LIST 200");
        List barangList = response.data;
        return barangList;
      } else {
        // Handle error cases if needed
        log('Error: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Handle Dio errors or network issues
      log('Dio Error: $error');
      return [];
    }
  }

  Future selectBarang(String id) async {
    FormData formData = FormData.fromMap({
      'idbarang': id,
    });
    // try {
    final response = await _dio.post(
      'https://thriftstore1.000webhostapp.com/selectdata.php',
      data: formData,
    );
    Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);
    // ${response.data['status]}
    log("Res $responseData");
    if (responseData['success'] == true) {
      responseData['data']['status'] = true;
      return responseData['data'];
    } else {
      return {'status': false, 'msg': responseData['msg']};
    }
  }

  Future editBarang(
      {required String id,
      required String nama,
      required String merk,
      required String harga,
      required String stok,
      required String date,
      File? image}) async {
    try {
      String fileName = basename(image!.path).split('/').last;
      ;
      Map<String, dynamic> formDataMap = {
        'idbarang': id,
        'nama': nama,
        'merk': merk,
        'harga': harga,
        'stok': stok,
        'tanggal': date,
      };
      if (image != null) {
        formDataMap['url_image'] =
            await MultipartFile.fromFile(image.path, filename: fileName);
      }
      FormData formData = FormData.fromMap(formDataMap);

      Response response = await _dio.post(
        'https://thriftstore1.000webhostapp.com/edit_barang.php',
        data: formData,
      );

      log("RES ${response.data}");
      // return response.data['status'];
      if (response.statusCode == 200 && response.data['status'] == true) {
        return true;
      } else {
        return false;
        // throw Exception('Failed to edit barang');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future deleteBarang(String id) async {
    try {
      FormData formData = FormData.fromMap({
        'idbarang': id,
      });
      final response = await _dio.post(
        'https://thriftstore1.000webhostapp.com/hapus_barang.php',
        data: formData,
      );
      Map responseData = response.data;
      if (responseData['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
