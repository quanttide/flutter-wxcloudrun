/// 微信云托管APIClient
///
/// 用以Flutter客户端访问微信云托管提供的服务。
/// 提供了对冷启动状态下503状态码的处理。

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


/// 微信云托管APIClient
///
class WXCloudRunAPIClient {

  // TODO: 通过调制RetryClient参数调整冷启动处理策略。
  http.Client client = RetryClient(http.Client());

  /// 请求服务API
  Future<http.Response> requestAPI(String method,
      String apiRoot, String apiPath, {Map<String, dynamic>? queryParameters}
      ) async {
    http.Request request = http.Request(method,
        Uri.https(apiRoot, apiPath, queryParameters),
    );
    http.Response response = (await client.send(request)) as http.Response;
    return response;
  }
}
