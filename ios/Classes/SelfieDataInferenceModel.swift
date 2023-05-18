//
//  SelfieDataInferenceModel.swift
//  smart_selfie_ai_model
//
//  Created by Sudarshan Chakra on 23/12/21.
//

import Foundation
import TensorIO

class SelfieDataInferenceModel {
    
    func infereDataOn(image: UIImage,
                      completion: @escaping (Result<SelfieData, SelfieDataInferenceError>
                      ) -> Void){
        
        guard let pixels = image.pixelBuffer() else {
            completion(.failure(SelfieDataInferenceErrors.invalidDataForImage))
            return
        }
        
        let value = pixels.takeUnretainedValue() as CVPixelBuffer
        let buffer = TIOPixelBuffer(pixelBuffer:value, orientation: .up)
        let bundle = Bundle(for: SmartSelfieAiModelPlugin.self)
        guard let modelPath = bundle.path(forResource: "phenomenal-face", ofType: "tiobundle") else {
            completion(.failure(SelfieDataInferenceErrors.modelPathNotFound))
            return
        }
        
        guard let model = TIOTFLiteModel.withBundleAtPath(modelPath) else {
            completion(.failure(SelfieDataInferenceErrors.modelPathNotFound))
            return
        }
        
        let result = model.run(on: buffer)
        if let resultDictionary = result as? NSDictionary {
            let weight: Double = (resultDictionary["Weight"] as? Double) ?? 0.0
            let height: Double = (resultDictionary["Height"] as? Double) ?? 0.0
            let age = (resultDictionary["Age"] as? Double) ?? 0
            let genderQuantifier = (resultDictionary["Sex"] as? Double) ?? 0.0
            let gender = genderQuantifier > 0.5 ? "male" : ((genderQuantifier == 0) ? "none" : "female")
            
            let data = SelfieData(
                age: age,
                gender: gender,
                weight: weight,
                height: height
            )
            completion(.success(data))
        }else{
            completion(.failure(SelfieDataInferenceErrors.noDataDetected))
        }
        
    }
}
