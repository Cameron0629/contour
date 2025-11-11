import SwiftUI

// Placeholder view needed for compilation


struct SettingsView: View {
    var body: some View {
        // List automatically handles the content filling the view
        List {
            Section("Account") {
                NavigationLink("User Info", destination: UserInfoView())
                Text("Change Password")
                // Using a Button for the logout action is more idiomatic
                Button("Logout") {
                    // Actual logout logic here
                    print("Logged out")
                }
                .foregroundColor(.red)
            }
            Section("App") {
                Text("Notifications")
                Text("Privacy Policy")
            }
        }
        // Adding navigationTitle here ensures it appears in the NavigationStack
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
