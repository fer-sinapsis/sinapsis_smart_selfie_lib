package com.sinapsis.smart_selfie_ai_model

import kotlin.math.pow
import kotlin.math.roundToInt

data class SelfieData(val age: Double, val gender: String,
                      val weight: Double, val height: Double)

fun SelfieData.toMap(): HashMap<String, Any?> {
    val bmi = (this.weight / (this.height * this.height)) * 10000
    return hashMapOf(
        "age" to this.age.roundTo(2),
        "weight" to this.weight.roundTo(2),
        "gender" to this.gender,
        "height" to this.height.roundTo(2),
        "bmi" to bmi.roundTo(2)
    )
}

fun Double.roundTo(numFractionDigits: Int): Double {
    val factor = 10.0.pow(numFractionDigits.toDouble())
    return (this * factor).roundToInt() / factor
}