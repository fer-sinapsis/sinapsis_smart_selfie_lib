import Flutter
import UIKit

public class SwiftSmartSelfieAiModelPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "smart_selfie_ai_model", binaryMessenger: registrar.messenger())
        let instance = SwiftSmartSelfieAiModelPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getDataFromSelfie" {
            self.getDataFromSelfie(arguments: call.arguments, flutterResult: result)
        }
    }
    
    func getDataFromSelfie(arguments: Any?, flutterResult: @escaping FlutterResult){
        guard let argsData = arguments as? FlutterStandardTypedData else {
            let error = SelfieDataInferenceErrors.invalidDataType
            flutterResult(FlutterError(code: error.code,
                                       message: error.message,
                                       details: nil))
            return
        }
        
        guard let image = UIImage(data: argsData.data) else{
            let error = SelfieDataInferenceErrors.invalidDataForImage
            flutterResult(FlutterError(code: error.code,
                                       message: error.message,
                                       details: nil))
            return
        }
        
        let selfieModel = SelfieDataInferenceModel()
        selfieModel.infereDataOn(image: image) { result in
            switch result {
            case .success(let selfieData):
                flutterResult(selfieData.toDictionary())
            case .failure(let error):
                flutterResult(
                    FlutterError(code: error.code, message: error.message, details: nil)
                )
            }
        }
    }
    
}
