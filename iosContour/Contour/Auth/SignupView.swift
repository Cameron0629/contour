import SwiftUI

struct SignupView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.title)
                .fontWeight(.bold)

            VStack(spacing: 15) {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)

            Button("Create Account") {}
                .buttonStyle(.borderedProminent)
                .tint(.contourPurple)

            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SignupView()
    }
}
