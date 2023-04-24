import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tenjin/flutter_tenjin.dart';
import 'package:flutter_tenjin/flutter_tenjin_platform_interface.dart';
import 'package:flutter_tenjin/flutter_tenjin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterTenjinPlatform
    with MockPlatformInterfaceMixin
    implements FlutterTenjinPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterTenjinPlatform initialPlatform = FlutterTenjinPlatform.instance;

  test('$MethodChannelFlutterTenjin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterTenjin>());
  });

  test('getPlatformVersion', () async {
    FlutterTenjin flutterTenjinPlugin = FlutterTenjin();
    MockFlutterTenjinPlatform fakePlatform = MockFlutterTenjinPlatform();
    FlutterTenjinPlatform.instance = fakePlatform;

    expect(await flutterTenjinPlugin.getPlatformVersion(), '42');
  });
}
