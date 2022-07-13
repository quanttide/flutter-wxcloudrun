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
    WXCloudRunAPIClient apiClient = MockWXCloudRunAPIClient(apiRoot: 'api.example.com');

    test('正常请求', () async {
      // 打桩
      when(apiClient.requestAPI('GET', '/path')).thenAnswer(
              (_) async => http.Response('OK', 200)
      );
      // 测试
      http.Response response = await apiClient.requestAPI('GET', '/path');
      expect(response.statusCode, 200);
      expect(response.body, 'OK');
    });
    test('冷启动', () async {
      // 打桩
      when(apiClient.requestAPI('GET', '/path')).thenAnswer(
              (_) async => http.Response('Cold Starting', 503)
      );
      // 测试
      http.Response response = await apiClient.requestAPI('GET', '/path');
      expect(response.statusCode, 503);
      expect(response.body, 'Cold Starting');
    });
    test('请求失败', () async {
      // 打桩
      when(apiClient.requestAPI('GET', '/path')).thenAnswer(
              (_) async => http.Response('Not Found', 404)
      );
      // 测试
      http.Response response = await apiClient.requestAPI('GET', '/path');
      expect(response.statusCode, 404);
      expect(response.body, 'Not Found');
    });
  });
}
