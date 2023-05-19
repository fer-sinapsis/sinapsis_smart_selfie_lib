
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class SmartSelfieAiModel {
  static const MethodChannel _channel = MethodChannel('smart_selfie_ai_model');

  static Future<Map> getDataFromSelfie(Uint8List imageBytes) async {
    try {
      final Map detectedInfo = await _channel.invokeMethod('getDataFromSelfie', imageBytes);
      return detectedInfo;
    } catch(e){
      rethrow;
    }
  }
}
