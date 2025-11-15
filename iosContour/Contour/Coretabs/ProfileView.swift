// ProfileView.swift

import SwiftUI
import SceneKit // Keep this import for the 3D features

// 1. **REQUIRED FIX: Ensure EditProfileView is defined here**
struct EditProfileView: View {
    @State private var newUsername: String = "ExampleUser"
    @State private var newBio: String = "A simple bio about me."
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                // ... (rest of your EditProfileView body code) ...
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
// -----------------------------------------------------------

// 2. ProfileView begins here (with the updated bindings)
struct ProfileView: View {
    @State private var username: String = "ExampleUser"
    @State private var bio: String = "..."
    @State private var showingEditProfile = false
    @State private var modelURL: URL? // The new binding
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Picture Section
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
                
                // Action Buttons
                VStack(spacing: 15) {
                    NavigationLink(destination: CreateScanView(modelURL: $modelURL)) {
                        HStack {
                            Image(systemName: "camera.viewfinder")
                            Text("Create New Scan")
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.contourPurple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: ModelView(modelURL: $modelURL)) {
                        HStack {
                            Image(systemName: "cube.fill")
                            Text("View 3D Model")
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.contourBlue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // Edit Profile Button
                Button {
                    showingEditProfile = true
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Profile")
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.primary)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $showingEditProfile) {
            EditProfileView()
        }
    }
}
