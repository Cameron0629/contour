import SwiftUI

// --- Placeholder Helper Views (Kept in this file for simplicity) ---

struct EditProfileView: View {
    @State private var newUsername: String = "ExampleUser"
    @State private var newBio: String = "A simple bio about me."
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture")) {
                    HStack {
                        Spacer()
                        VStack {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Image(systemName: "camera.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                )
                                .onTapGesture {
                                    // Action to pick a new profile picture
                                }
                            Text("Tap to change picture")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                }

                Section(header: Text("Username")) {
                    TextField("Username", text: $newUsername)
                }

                Section(header: Text("Bio")) {
                    TextEditor(text: $newBio)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // In a real app, save logic would go here
                        dismiss()
                    }
                    .bold()
                }
            }
        }
    }
}

// --- Main Profile View ---
struct ProfileView: View {
    @State private var username: String = "ExampleUser"
    @State private var bio: String = "Designing and building the future, one scan at a time. Tech enthusiast and creator."
    @State private var showingEditProfile = false
    
    // Placeholder views needed for compilation
    struct CreateScanView: View { var body: some View { Text("Create Scan View") } }
    struct ModelView: View { var body: some View { Text("3D Model View") } }

    var body: some View {
        // Removed the outer NavigationView since it's now wrapped by NavigationStack in MainTabView
        VStack(alignment: .leading, spacing: 25) {

            // Profile Header: Picture, Username, and Bio
            HStack(alignment: .top) {
                // Circular Profile Picture Placeholder (Top Left)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Text(String(username.prefix(1)))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    )
                    .padding(.trailing, 10)

                VStack(alignment: .leading, spacing: 4) {
                    // Username
                    Text(username)
                        .font(.title2)
                        .fontWeight(.bold)
                    // Bio
                    Text(bio)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }

                Spacer()
            }
            .padding(.horizontal)
            
            Divider()

            // Edit Profile Button
            Button {
                showingEditProfile = true
            } label: {
                Text("Edit Profile")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)

            Divider()

            // Navigation Links
            VStack(spacing: 15) {
                // Button 1: Camera Scanning Link
                NavigationLink(destination: CreateScanView()) {
                    HStack {
                        Image(systemName: "camera.viewfinder").foregroundColor(.contourPurple)
                        Text("Create Your Scan")
                        Spacer()
                        Image(systemName: "chevron.right").foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color.contourPurple.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.primary)

                // Button 2: 3D Model View Link (Now pointing to ModelView)
                NavigationLink(destination: ModelView()) {
                    HStack {
                        Image(systemName: "cube.transparent").foregroundColor(.contourBlue)
                        Text("Your 3D Model")
                        Spacer()
                        Image(systemName: "chevron.right").foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color.contourBlue.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.primary)
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $showingEditProfile) {
            EditProfileView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        // Wrap in a NavigationStack for accurate preview
        NavigationStack {
            ProfileView()
        }
    }
}
