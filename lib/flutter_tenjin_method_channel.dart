import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_tenjin_platform_interface.dart';

/// An implementation of [FlutterTenjinPlatform] that uses method channels.
class MethodChannelFlutterTenjin extends FlutterTenjinPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_tenjin');

  @override
  void setCallBack(Future Function(MethodCall call)? handler) {
    methodChannel.setMethodCallHandler(handler);
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> init(String sdkKey) async {
    final initResult =
        await methodChannel.invokeMethod<bool>('init', {"sdkKey": sdkKey});
    return initResult;
  }

  @override
  Future<bool?> sendPurchaseEvent(String productId, String currencyCode,
      int quantity, double unitPrice) async {
    final sendResult =
        await methodChannel.invokeMethod<bool>('sendPurchaseEvent', {
      "productId": productId,
      "currencyCode": currencyCode,
      "quantity": quantity,
      "unitPrice": unitPrice
    });
    return sendResult;
  }

  @override
  Future<bool?> sendEventWithName(String eventName, value) async {
    final sendEventResult = await methodChannel
        .invokeMethod('eventWithName', {"eventName": eventName, "value": value});
    return sendEventResult;
  }
}
