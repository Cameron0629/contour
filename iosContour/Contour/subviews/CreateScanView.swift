import SwiftUI

/// The view where the user initiates a new 3D scan using the device camera.
struct CreateScanView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Ready to Scan?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            // Placeholder for the Camera Viewfinder
            // In a real app, this would be replaced by a UIViewControllerRepresentable
            // hosting the actual camera session.
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .aspectRatio(3/4, contentMode: .fit) // Typical phone aspect ratio
                    .cornerRadius(15)
                
                // Overlay for the scanning frame
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.green, lineWidth: 4)
                    .frame(width: 250, height: 350)
                
                Image(systemName: "video.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .foregroundColor(Color.gray.opacity(0.8))
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Start Scanning Button
            Button {
                // TODO: Implement the camera setup and start scan logic here
                print("Starting 3D Scan...")
            } label: {
                Text("Start Scanning")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .navigationTitle("New Scan")
    }
}

struct CreateScanView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateScanView()
        }
    }
}
