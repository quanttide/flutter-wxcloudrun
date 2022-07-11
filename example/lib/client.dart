/// APIClient示例

import 'package:flutter_wxcloudrun/flutter_wxcloudrun_sdk.dart';

import 'environment_config.dart';


/// 自定义APIClient类
class CustomAPIClient extends WXCloudRunAPIClient {

  CustomAPIClient() : super(
    apiRoot: EnvironmentConfig.apiRoot,
    format: 'json'
  );

  /// 示例API
  Future<dynamic> exampleAPI() async {
    List<Map<String, dynamic>> data = await requestAPI('GET', EnvironmentConfig.apiPath);
    return data;
  }
}
