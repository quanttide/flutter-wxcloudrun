/// 微信云托管APIClient
///
/// 用以Flutter客户端访问微信云托管提供的服务。
/// 提供了对冷启动状态下503状态码的处理。

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:http/testing.dart';


/// 微信云托管APIClient
class WXCloudRunAPIClient {
  /// 是否Mock
  bool mock;
  /// Mock函数
  MockClientHandler? mockClientHandler;
  /// HTTP客户端
  late http.Client client;

  WXCloudRunAPIClient({
    this.mock=false,
    this.mockClientHandler,
  }){
    if (mock){
      client = MockClient(mockClientHandler!);
    }
    else {
      client = http.Client();
    }
    // TODO: 通过调节RetryClient参数调整冷启动处理策略。
    client = RetryClient(client);
  }

  /// 请求服务API
  Future<dynamic> requestAPI({
    required String httpMethod,
    required String apiRoot,
    required String apiPath,
    Map<String, dynamic>? queryParameters
  }) async {
    http.Request request = http.Request(
      httpMethod,
      Uri.https(apiRoot, apiPath, queryParameters),
    );
    http.StreamedResponse response = await client.send(request);
    return response;
  }

  /// 处理返回值
  ///
  /// TODO：增加除了json格式之外的处理。
  dynamic parseResponse(http.Response response){
    // https://stackoverflow.com/questions/55865173/how-to-decode-json-string-as-utf-8
    return json.decode(utf8.decode(response.bodyBytes));
  }
}
