import SwiftUI

/// The destination view for displaying the user's 3D model or model list.
struct ModelView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Your 3D Model")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)

            // Placeholder for the 3D Model/Viewer Area
            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .cornerRadius(15)
                    .overlay(
                        VStack {
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
                
                Text("Your latest model will appear here.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("3D Model")
    }
}

struct ModelView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ModelView()
        }
    }
}
