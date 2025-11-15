import SwiftUI
import ARKit

struct CreateScanView: View {
    @Binding var modelURL: URL?
    private let scannerProxy = LidarScannerView.ScannerProxy()
    @Environment(\.dismiss) var dismiss
    
    private static var isLiDARSupported: Bool {
        ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh)
    }
    
    var body: some View {
        if Self.isLiDARSupported {
            scannerView
        } else {
            incompatibleDeviceView
        }
    }
    
    private var scannerView: some View {
        ZStack(alignment: .bottom) {
            LidarScannerView(proxy: scannerProxy)
                .ignoresSafeArea()
            
            Button {
                if let url = scannerProxy.exportAction?() {
                    modelURL = url
                    dismiss()
                }
            } label: {
                Text("Stop & Save 3D Model")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle("Scanning...")
        .navigationBarBackButtonHidden(true)
    }
    
    private var incompatibleDeviceView: some View {
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
            
            Button("Go Back") { dismiss() }
                .buttonStyle(.borderedProminent)
                .padding(.top, 20)
        }
        .padding()
        .navigationTitle("Scanning")
    }
}

#Preview {
    NavigationStack {
        CreateScanView(modelURL: .constant(nil))
    }
}
