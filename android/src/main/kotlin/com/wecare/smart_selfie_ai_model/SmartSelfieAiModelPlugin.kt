package com.wecare.smart_selfie_ai_model

import android.graphics.BitmapFactory
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.Exception

/** SmartSelfieAiModelPlugin */
class SmartSelfieAiModelPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var flPluginBinding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "smart_selfie_ai_model")
    flPluginBinding = flutterPluginBinding
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getDataFromSelfie") {
      this.getDataFromSelfie(call.arguments, result)
    } else {
      result.notImplemented()
    }
  }

  fun getDataFromSelfie(@NonNull arguments: Any?, @NonNull result: Result){
    var bytes: ByteArray
    if (arguments is ByteArray) {
      bytes = arguments as ByteArray
    }else{
      val exception = SelfieDataInferenceErrors.invalidDataType
      result.error(exception.code, exception.message, null)
      return
    }

    val selfieModel = SelfieDataInfereceModel()
    try {
      val image = BitmapFactory.decodeByteArray(bytes, 0, bytes.count())

      selfieModel.infereDataOn(image, appContext = flPluginBinding.applicationContext) { detectedResult ->
        detectedResult.fold(
          onSuccess = { selfieData ->
            result.success(selfieData.toMap())
          },
          onFailure = { exception ->
            result.error((exception as SelfieDataInferenceException).code, exception.message, null)
          }
        )
      }
    } catch (exception: Exception) {
      val exception = SelfieDataInferenceErrors.invalidDataForImage
      result.error(exception.code, exception.message, null)
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
