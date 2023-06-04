import UIKit
import Flutter
import Firebase
import FirebaseCore
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    // let providerFactory = AppCheckDebugProviderFactory()
    // AppCheck.setAppCheckProviderFactory(providerFactory)
    
    FirebaseApp.configure()
    self.window.makeSecure()
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

      Messaging.messaging().apnsToken = deviceToken
      // print("Token: \(deviceToken)")
      super.application(application,
      didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }
}

extension UIWindow {
  func makeSecure() {
      let field = UITextField()
      field.isSecureTextEntry = true
      self.addSubview(field)
      field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      self.layer.superlayer?.addSublayer(field.layer)
      field.layer.sublayers?.first?.addSublayer(self.layer)
    }
  }
