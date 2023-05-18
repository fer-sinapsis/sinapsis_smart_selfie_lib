//
//  SelfiePredictionErrors.swift
//  smart_selfie_ai_model
//
//  Created by Sudarshan Chakra on 23/12/21.
//

import Foundation

class SelfieDataInferenceError: Error {
    init(code: String, message: String){
        self.code = code
        self.message = message
    }
    var code: String
    var message: String
}

class SelfieDataInferenceErrors {
    static let invalidDataType = SelfieDataInferenceError(code: "invalid_data_type",
                                                    message: "invalid argument data type")
    static let invalidDataForImage = SelfieDataInferenceError(code: "invalid_data_for_image",
                                                    message: "not possible to create the image with the data passed")
    
    static let noDataDetected = SelfieDataInferenceError(code: "no_data_detected",
                                                   message: "no selfie data detected")
    
    static let modelPathNotFound = SelfieDataInferenceError(code:"model_path_not_found",
                                                            message: "model path not found")
    
}
