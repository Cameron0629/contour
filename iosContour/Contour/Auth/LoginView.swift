import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Contour")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(
                        colors: [.contourBlue, .contourPurple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))

                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)

                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)

                Button("Login") {
                    isLoggedIn = true
                }
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

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
