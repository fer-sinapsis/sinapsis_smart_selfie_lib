package com.sinapsis.smart_selfie_ai_model

import android.graphics.Bitmap
import ai.doc.tensorio.core.modelbundle.ModelBundle
import java.lang.Exception

class SelfieDataInfereceModel {
    fun infereDataOn(bitmap: Bitmap, appContext: android.content.Context, completion: (Result<SelfieData>) -> Unit){
        try {
            val bundle = ModelBundle.bundleWithAsset(appContext, "phenomenal-face.tiobundle")
            val model = bundle.newModel()
            val output = model.runOn(bitmap)

            val height = (output["Height"] as? FloatArray)?.get(0)
            val age = (output["Age"] as? FloatArray)?.get(0)
            val weight = (output["Weight"] as? FloatArray)?.get(0)
            val genderQuantifier = (output["Sex"] as? FloatArray)?.get(0)

            if(height != null && age != null && weight != null && genderQuantifier != null) {
                val gender = if (genderQuantifier > 0.5) "Male" else "Female"
                val selfieData =
                    SelfieData(age.toDouble(), gender, weight.toDouble(), height.toDouble())
                completion(Result.success(selfieData))
            }else{
                completion(Result.failure(SelfieDataInferenceErrors.noDataDetected))
            }
        } catch (exception: Exception) {
            completion(Result.failure(SelfieDataInferenceErrors.modelExecutionFailed))
        }
    }
}