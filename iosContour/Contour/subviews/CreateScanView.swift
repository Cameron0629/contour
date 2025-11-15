// CreateScanView.swift

import SwiftUI
import UIKit
import ARKit // Make sure this is imported

/// The view where the user initiates a new 3D scan using the device camera.
struct CreateScanView: View {
    
    // 1. RECEIVE: The binding for the model URL
    @Binding var modelURL: URL?
    
    // 2. PROXY: Create the proxy object to communicate with the AR ViewController
    private let scannerProxy = LidarScannerView.ScannerProxy()
    
    @Environment(\.dismiss) var dismiss
    
    // Check if the device supports LiDAR scanning
    nonisolated private static func checkLiDARSupport() -> Bool {
        return ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh)
    }
    
    var body: some View {
        // Check for LiDAR compatibility
        if Self.checkLiDARSupport() {
            // 3. ZStack to overlay the button on the scanner view
            ZStack(alignment: .bottom) {
                
                // 4. HOST: The LidarScannerView
                LidarScannerView(proxy: scannerProxy)
                    .edgesIgnoringSafeArea(.all)
                
                // 5. Button to stop the scan and save the file
                Button {
                    // Call the export function via the proxy
                    if let url = scannerProxy.exportAction?() {
                        // Set the binding with the saved file URL
                        self.modelURL = url
                        // Dismiss this view and return to ProfileView
                        dismiss()
                    } else {
                        print("Error: Could not export 3D model.")
                        // TODO: Show a user-friendly alert here
                    }
                } label: {
                    Text("Stop & Save 3D Model")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding()
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Scanning...")
            .navigationBarBackButtonHidden(true) // Hide the back button while scanning
        } else {
            // Show error message for incompatible devices
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.orange)
                
                Text("Device Not Compatible")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("This phone is not compatible with LiDAR scanning")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button {
                    dismiss()
                } label: {
                    Text("Go Back")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .padding()
            .navigationTitle("Scanning")
            .navigationBarBackButtonHidden(false)
        }
    }
}

struct CreateScanView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            // Update the preview to provide a constant binding
            CreateScanView(modelURL: .constant(nil))
        }
    }
}
