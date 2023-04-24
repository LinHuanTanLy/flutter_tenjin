import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_tenjin_method_channel.dart';

abstract class FlutterTenjinPlatform extends PlatformInterface {
  /// Constructs a FlutterTenjinPlatform.
  FlutterTenjinPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterTenjinPlatform _instance = MethodChannelFlutterTenjin();

  /// The default instance of [FlutterTenjinPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterTenjin].
  static FlutterTenjinPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterTenjinPlatform] when
  /// they register themselves.
  static set instance(FlutterTenjinPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void setCallBack(Future<dynamic> Function(MethodCall call)? handler) {
    throw UnimplementedError('setCallBack() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> init(String sdkKey) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<bool?> sendPurchaseEvent(
      String productId, String currencyCode, int quantity, double unitPrice);

  Future<bool?> sendEventWithName(String eventName,dynamic value);
}
