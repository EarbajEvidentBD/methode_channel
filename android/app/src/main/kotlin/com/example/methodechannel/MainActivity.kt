package com.example.methodechannel

import io.flutter.embedding.android.FlutterActivity

import android.os.Bundle
import fetchApiData
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.net.HttpURLConnection
import java.net.URL


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example/my_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getNativeInteger" -> {
                    // Call a function and return an integer
                    val integerValue = getNativeInteger()
                    result.success(integerValue)
                }

                "getNativeString" -> {
                    // Call a function and return a string
                    val stringValue = getNativeString()
                    result.success(stringValue)
                }

                "getNativeBoolean" -> {
                    // Call a function and return a boolean
                    val booleanValue = getNativeBoolean()
                    result.success(booleanValue)
                }

                "fetchApiData" -> {
                    // Call the function to fetch data from the API
                    fetchApiData { response ->
                        result.success(response)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    // Function that returns an integer value
    private fun getNativeInteger(): Int {
        return 42
    }

    // Function that returns a string value
    private fun getNativeString(): String {
        return "Hello from Kotlin!"
    }

    // Function that returns a boolean value
    private fun getNativeBoolean(): Boolean {
        return true
    }

}
