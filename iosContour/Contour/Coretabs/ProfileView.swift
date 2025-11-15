import SwiftUI

struct EditProfileView: View {
    @State private var newUsername: String = "ExampleUser"
    @State private var newBio: String = "A simple bio about me."
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profile Picture")) {
                    VStack(spacing: 8) {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "camera.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            )
                        Text("Tap to change picture")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
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
                    Button("Save") { dismiss() }
                        .bold()
                }
            }
        }
    }
}

struct ProfileView: View {
    @State private var username: String = "ExampleUser"
    @State private var bio: String = "..."
    @State private var showingEditProfile = false
    @State private var modelURL: URL?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                        .overlay(
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        )
                    
                    Text(username)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(bio)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                VStack(spacing: 15) {
                    actionButton(
                        icon: "camera.viewfinder",
                        title: "Create New Scan",
                        color: .contourPurple,
                        destination: CreateScanView(modelURL: $modelURL)
                    )
                    
                    actionButton(
                        icon: "cube.fill",
                        title: "View 3D Model",
                        color: .contourBlue,
                        destination: ModelView(modelURL: $modelURL)
                    )
                }
                .padding(.horizontal)
                
                Button {
                    showingEditProfile = true
                } label: {
                    Label("Edit Profile", systemImage: "pencil")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $showingEditProfile) {
            EditProfileView()
        }
    }
    
    private func actionButton<Destination: View>(
        icon: String,
        title: String,
        color: Color,
        destination: Destination
    ) -> some View {
        NavigationLink(destination: destination) {
            Label(title, systemImage: icon)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}
