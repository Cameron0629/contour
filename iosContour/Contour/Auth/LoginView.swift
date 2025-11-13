import SwiftUI

struct LoginView: View {
    // 1. Receive the binding from ContourApp
    @Binding var isLoggedIn: Bool
    
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

                // 2. *** NAVIGATION CHANGE: Changed to a Button ***
                Button("Login") {
                    // 3. Update the state variable directly
                    isLoggedIn = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.contourBlue)

                // This NavigationLink is fine, as it navigates *within* the "Logged Out" flow
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
        // 4. Fix the preview by providing a "constant" binding
        LoginView(isLoggedIn: .constant(false))
    }
}
