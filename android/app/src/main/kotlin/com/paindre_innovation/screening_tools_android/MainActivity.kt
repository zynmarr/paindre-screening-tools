package com.paindre_innovation.screening_tools_android

import android.os.Bundle
import com.google.firebase.Firebase
import io.flutter.embedding.android.FlutterActivity
import com.google.firebase.FirebaseApp
import com.google.firebase.appcheck.FirebaseAppCheck
import com.google.firebase.appcheck.appCheck
import com.google.firebase.appcheck.playintegrity.PlayIntegrityAppCheckProviderFactory
import io.flutter.Log

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initFirebase()
    }

    private fun initFirebase() {
        // Initialize Firebase
        Log.d("Initial-AppCheck", "Initializing Firebase AppCheck")
        FirebaseApp.initializeApp(this)
        // Initialize App Check
        val firebaseAppCheck: FirebaseAppCheck = FirebaseAppCheck.getInstance()
        // Use Play Integrity for production
        Firebase.appCheck.installAppCheckProviderFactory(
            PlayIntegrityAppCheckProviderFactory.getInstance(),
        )
        Log.d("AppCheck", "Using Play Integrity App Check")
        // Add a listener for App Check tokens
        firebaseAppCheck.addAppCheckTokenListener { token ->
            Log.d("AppCheck", "Token: ${token.token}")
        }
    }
}