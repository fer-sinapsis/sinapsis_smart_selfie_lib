package com.wecare.smart_selfie_ai_model

class SelfieDataInferenceException(val code: String, message: String? = null) : Exception(message)

class SelfieDataInferenceErrors {
    companion object {
        val invalidDataType = SelfieDataInferenceException(
            "invalid_data_type",
            "invalid argument data type"
        )
        val invalidDataForImage = SelfieDataInferenceException(
            "invalid_data_for_image",
            "not possible to create the image with the data passed"
        )
        val noDataDetected = SelfieDataInferenceException(
            "no_data_detected",
            "no selfie data detected"
        )
        val modelExecutionFailed = SelfieDataInferenceException(
            "model_execution_failed",
            "loading or executing the model has failed"
        )
    }
}