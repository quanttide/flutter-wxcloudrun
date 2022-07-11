/// APIClient示例

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_wxcloudrun/flutter_wxcloudrun_sdk.dart';

import 'environment_config.dart';


/// 自定义APIClient类
class CustomAPIClient extends WXCloudRunAPIClient {
  String apiRoot = EnvironmentConfig.apiRoot;

  /// 自定义API
  Future<dynamic> getAPI(String apiPath, {Map<String, dynamic>? queryParameters}) async {
    http.Response response = await requestAPI(
        'GET', apiRoot, apiPath, queryParameters: queryParameters
    );
    // https://stackoverflow.com/questions/55865173/how-to-decode-json-string-as-utf-8
    return json.decode(utf8.decode(response.bodyBytes));
  }

  /// 示例API
  Future<dynamic> exampleAPI() async {
    List<dynamic> data = await getAPI(EnvironmentConfig.apiPath);
    return data;
  }
}