package com.ly.flutter_tenjin

import android.app.Activity
import android.app.Application
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.tenjin.android.TenjinSDK
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** FlutterTenjinPlugin */
class FlutterTenjinPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    Application.ActivityLifecycleCallbacks {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private lateinit var instance: TenjinSDK
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_tenjin")
        channel.setMethodCallHandler(this)

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "init" -> init(call, result)
            "sendPurchaseEvent" -> sendPurchaseEvent(call, result)
            "eventWithName" -> sendEventWithName(call, result)
        }
    }

    private fun init(call: MethodCall, result: Result) {
        instance = TenjinSDK.getInstance(activity, call.argument("sdkKey") as? String)
        println(instance.toString())
        instance.setAppStore(TenjinSDK.AppStoreType.googleplay)
        instance.connect()

        return result.success(true)
    }

    private fun sendEventWithName(call: MethodCall, result: Result) {
        val eventName = call.argument("eventName") as? String
        val value = call.argument("value") as? Any
        println("the eventName is $eventName the value is $value")
        if (value != null) {
            if (value is Int) {
                instance.eventWithNameAndValue(eventName, value)
            } else if (value is String) {
                instance.eventWithNameAndValue(eventName, value)
            }
        } else {
            instance.eventWithName(eventName)
        }

        result.success(true)
    }


    private fun sendPurchaseEvent(call: MethodCall, result: Result) {
        val productId = call.argument("productId") as? String
        val currencyCode = call.argument("currencyCode") as? String
        var quantity = call.argument("quantity") as? Int
        var unitPrice = call.argument("unitPrice") as? Double
        if (quantity == null) {
            quantity = 1;
        }
        if (unitPrice == null) {
            unitPrice = 0.0;
        }
        println("$productId $currencyCode $quantity $unitPrice")
        instance.transaction(productId, currencyCode, quantity, unitPrice)
        result.success(true)
    }

    @RequiresApi(Build.VERSION_CODES.Q)
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        activity?.registerActivityLifecycleCallbacks(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onActivityCreated(activity: Activity, p1: Bundle?) {
    }

    override fun onActivityStarted(activity: Activity) {
    }

    override fun onActivityResumed(activity: Activity) {
        println("onResume")
        channel.invokeMethod("onResume", null)
    }

    override fun onActivityPaused(activity: Activity) {
    }

    override fun onActivityStopped(activity: Activity) {
    }

    override fun onActivitySaveInstanceState(activity: Activity, p1: Bundle) {
    }

    override fun onActivityDestroyed(activity: Activity) {
    }


}
