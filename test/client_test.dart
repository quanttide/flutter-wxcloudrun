/// 微信云托管APIClient测试
///
/// Mock方案: https://pub.dev/packages/mockito

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_wxcloudrun/src/client.dart';
import 'client_test.mocks.dart';


@GenerateMocks([WXCloudRunAPIClient])
void main() {
  group('APIClient测试', () {
    WXCloudRunAPIClient apiClient = MockWXCloudRunAPIClient();
    test('正常请求', () async {
      http.Response response = await apiClient.requestAPI('GET', 'api.example.com', 'path');
    });
    test('冷启动', () async {

    });
    test('请求失败', () async{

    });
  });
}
