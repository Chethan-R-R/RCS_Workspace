package com.mycompany.my_app

import android.content.Context
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val flutterNativeChannel = "RCS_App/nativeChannel"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            flutterNativeChannel
        ).setMethodCallHandler { call, result ->
            val context: Context = applicationContext
            when (call.method) {
                "getElapsedTime" -> {
                    val elapsedMillis = (SystemClock.elapsedRealtime() / 1000).toLong()
                    //val elapsedSeconds = elapsedMillis / 1000
                    //val hours = (elapsedSeconds / 3600).toInt()
                    //val minutes = ((elapsedSeconds % 3600) / 60).toInt()
                    //val seconds = (elapsedSeconds % 60).toInt()
                    //val formattedTime = String.format(Locale.getDefault(), "%02d:%02d:%02d", hours, minutes, seconds)
                    result.success(elapsedMillis)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
