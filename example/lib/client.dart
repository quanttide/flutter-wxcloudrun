/// APIClient示例

import 'package:flutter_wxcloudrun/flutter_wxcloudrun_sdk.dart';

import 'environment_config.dart';


/// 自定义APIClient类
class CustomAPIClient extends WXCloudRunAPIClient {

  /// 示例API
  Future<dynamic> exampleAPI() async {
    List<Map<String, dynamic>> data = await requestAPI(
        httpMethod: 'GET',
        apiRoot: EnvironmentConfig.apiRoot,
        apiPath: EnvironmentConfig.apiPath
    );
    return data;
  }
}
