
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class SinapsisSmartSelfieLib {
  static const MethodChannel _channel = MethodChannel('sinapsis_smart_selfie_lib');

  static Future<Map> getDataFromSelfie(Uint8List imageBytes) async {
    try {
      final Map detectedInfo = await _channel.invokeMethod('getDataFromSelfie', imageBytes);
      return detectedInfo;
    } catch(e){
      rethrow;
    }
  }
}
