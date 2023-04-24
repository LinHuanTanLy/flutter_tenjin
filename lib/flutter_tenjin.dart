import 'package:flutter/services.dart';

import 'flutter_tenjin_platform_interface.dart';

class FlutterTenjin {
  void setCallBack(Future Function(MethodCall call)? handler) {
    return FlutterTenjinPlatform.instance.setCallBack(handler);
  }

  Future<String?> getPlatformVersion() {
    return FlutterTenjinPlatform.instance.getPlatformVersion();
  }

  Future<bool?> init(String sdkKey) {
    return FlutterTenjinPlatform.instance.init(sdkKey);
  }

  Future<bool?> sendPurchaseEvent(String productId, String currencyCode,
      int quantity, double unitPrice) async {
    return FlutterTenjinPlatform.instance
        .sendPurchaseEvent(productId, currencyCode, quantity, unitPrice);
  }

  Future<bool?> sendEventWithName(String eventName, value) async {
    return FlutterTenjinPlatform.instance.sendEventWithName(eventName, value);
  }
}
