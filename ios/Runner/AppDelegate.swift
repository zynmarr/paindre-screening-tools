import Flutter
import UIKit
import Firebase
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // 1. Daftarkan semua plugin Flutter terlebih dahulu. Ini sangat penting.
    GeneratedPluginRegistrant.register(with: self)
    
    // 2. Setelah plugin terdaftar, baru konfigurasikan Firebase.
    FirebaseApp.configure()
    
    // Konfigurasi untuk notifikasi
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}