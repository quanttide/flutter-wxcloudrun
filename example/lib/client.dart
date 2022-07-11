/// APIClient示例

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'environment_config.dart';


/// 自定义APIClient类
class CustomAPIClient {
  String apiRoot = EnvironmentConfig.apiRoot;

  /// 请求API
  Future<dynamic> requestAPI(String apiPath, {Map<String, dynamic>? queryParameters}) async {
    Uri url = Uri.https(apiRoot, apiPath, queryParameters);
    http.Response response = await http.get(
        url,
        headers: {
          'content-type': 'application/json',
        }
    );
    // https://stackoverflow.com/questions/55865173/how-to-decode-json-string-as-utf-8
    return json.decode(utf8.decode(response.bodyBytes));
  }

  /// 示例API
  Future<dynamic> exampleAPI() async {
    List<dynamic> data = await requestAPI(EnvironmentConfig.apiPath);
    return data;
  }
}