import 'package:dio/dio.dart';

class FedaPayRequest {

  Future<Map<String, dynamic>> staticPostRequest({required String url, Map<String, dynamic> params = const {}, Map<String, String>? headers = const {}}) async {
    var dio = Dio(BaseOptions(headers: headers, baseUrl: url, contentType: "application/json"));
    var response = await dio.post("",data: FormData.fromMap(params));
    return response.data;
  }

  Future<Map<String, dynamic>> staticGetRequest({required String url, Map<String, dynamic> params = const {}, Map<String, String>? headers = const {}}) async {
    var dio = Dio(BaseOptions(headers: headers, baseUrl: url, contentType: "application/json"));
    var response = await dio.get("",queryParameters: params);
    return response.data;
  }
}
