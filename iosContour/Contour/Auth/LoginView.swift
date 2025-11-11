import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Contour")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(colors: [.contourBlue, .contourPurple],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing))

                VStack(spacing: 15) {
                    TextField("Email", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    SecureField("Password", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }

                // *** NAVIGATION CHANGE: Go to MainTabView after login ***
                NavigationLink("Login", destination: MainTabView())
                    .buttonStyle(.borderedProminent)
                    .tint(.contourBlue)

                NavigationLink("Sign Up", destination: SignupView())
                    .buttonStyle(.bordered)
                    .tint(.contourPurple)
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
