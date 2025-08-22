import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
    GMSServices.provideAPIKey("AIzaSyCvM2zsGo54ZCwNO5i63qtSnNjCthq1C7c")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
