/// 微信云托管APIClient
///
/// 用以Flutter客户端访问微信云托管提供的服务。
/// 提供了对冷启动状态下503状态码的处理。

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


/// 微信云托管APIClient
///
/// 为每个服务建立一个APIClient，
/// 他们提供同样的根路径（apiRoot）、数据类型（contentType）
///
/// 不同的服务可能使用不同的语言和框架，
/// apiRoot必然变化、数据类型可能不一样。
class WXCloudRunAPIClient {
  String apiRoot;
  String format;
  bool raw;

  WXCloudRunAPIClient({
    required this.apiRoot,
    this.format='json',
    this.raw=false,
  });

  // TODO: 通过调制RetryClient参数调整冷启动处理策略。
  http.Client client = RetryClient(http.Client());

  /// 请求服务API
  Future<dynamic> requestAPI(
      String method,
      String apiPath, {
        Map<String, dynamic>? queryParameters
      }) async {
    http.Request request = http.Request(
      method,
      Uri.https(apiRoot, apiPath, queryParameters),
    );
    http.Response response = (await client.send(request)) as http.Response;
    return parseResponse(response);
  }

  /// content-type
  get contentType {
    if (format == 'json'){
      return 'application/json';
    }
  }

  /// 处理返回值
  dynamic parseResponse(http.Response response){
    if (!raw){
      if (format == 'json'){
        // https://stackoverflow.com/questions/55865173/how-to-decode-json-string-as-utf-8
        return json.decode(utf8.decode(response.bodyBytes));
      }
    }
    else {
      // raw为真时返回原始response
      return response;
    }
  }
}
