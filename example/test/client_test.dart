/// 自定义APIClient测试

import "package:flutter_test/flutter_test.dart";

import '../lib/client.dart';


void main(){
  group('自定义APIClient测试', () {
    CustomAPIClient client = CustomAPIClient();
    test('请求示例API', () async {
      var data = await client.exampleAPI();
    });
  });
}
