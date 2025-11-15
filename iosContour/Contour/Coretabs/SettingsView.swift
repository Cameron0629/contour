import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section("Account") {
                NavigationLink("User Info", destination: UserInfoView())
                Text("Change Password")
                Button("Logout") {
                    print("Logged out")
                }
                .foregroundColor(.red)
            }
            Section("App") {
                Text("Notifications")
                Text("Privacy Policy")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
