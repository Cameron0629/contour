import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct ContourApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  // 1. Create the @State variable to track auth status
  @State private var isLoggedIn = false

  var body: some Scene {
    WindowGroup {
      // 2. Use an if-statement to swap the root view
      if isLoggedIn {
        // We pass the binding here so a "Logout" button inside MainTabView
        // (e.g., in Settings) can set this back to false.
        MainTabView(isLoggedIn: $isLoggedIn)
          .accentColor(.purple)
      } else {
        LoginView(isLoggedIn: $isLoggedIn)
          .accentColor(.purple)
      }
    }
  }
}
