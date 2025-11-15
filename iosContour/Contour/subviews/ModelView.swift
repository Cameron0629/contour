import SwiftUI
import SceneKit

struct ModelView: View {
    @Binding var modelURL: URL?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your 3D Model")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)

            if let url = modelURL {
                SceneView(
                    scene: loadScene(from: url),
                    options: [.allowsCameraControl, .autoenablesDefaultLighting]
                )
                .frame(maxWidth: .infinity, maxHeight: 400)
                .cornerRadius(15)
                .padding(.horizontal)
                
                Text("Your saved .obj model. Pinch to zoom, drag to rotate.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                placeholderView
            }

            Spacer()
        }
        .navigationTitle("3D Model")
    }
    
    private var placeholderView: some View {
        VStack(spacing: 12) {
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(height: 400)
                .cornerRadius(15)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: "cube.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.secondary)
                        Text("3D Model Viewer Placeholder")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                )
            
            Text("Take a scan from the Profile page to see your model here.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
    
    private func loadScene(from url: URL) -> SCNScene? {
        try? SCNScene(url: url, options: nil)
    }
}

#Preview {
    NavigationStack {
        ModelView(modelURL: .constant(nil))
    }
}
