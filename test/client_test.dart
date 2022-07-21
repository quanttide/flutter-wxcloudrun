/// 微信云托管APIClient测试
///
/// Mock方案: https://pub.dev/packages/mockito

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_wxcloudrun/src/client.dart';
import 'mock.dart';


void main() {
  group('APIClient测试', () {
    // 打桩
    WXCloudRunAPIClient apiClient = WXCloudRunAPIClient(
        mock: true,
        mockClientHandler: mockClientHandler
    );
    test('正常请求', () async {
      http.StreamedResponse response = await apiClient.requestAPI(
          httpMethod: 'GET',
          apiRoot: 'api.example.com',
          apiPath: '/path'
      );
      expect(response.statusCode, 200);
      // expect(response.stream, 'OK');
    });
    test('冷启动', () async {
      http.StreamedResponse response = await apiClient.requestAPI(
          httpMethod: 'GET',
          apiRoot: 'api.example.com',
          apiPath: '/cold_start'
      );
      expect(response.statusCode, 503);
      // expect(response.stream, 'Cold Starting');
    });
    test('请求失败', () async {
      http.StreamedResponse response = await apiClient.requestAPI(
          httpMethod: 'GET',
          apiRoot: 'api.example.com',
          apiPath: '/failed'
      );
      expect(response.statusCode, 404);
      // expect(response.stream, 'Not Found');
    });
  });
}
