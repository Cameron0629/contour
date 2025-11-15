import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            Text("Welcome to Contour! Use the tabs below to navigate.")
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Quick Scan") {}
                .buttonStyle(.borderedProminent)
                .tint(.contourBlue)

            Button("See Latest Look") {}
                .buttonStyle(.bordered)
                .tint(.contourPurple)

            Spacer()
        }
        .padding()
        .navigationTitle("Dashboard")
    }
}

#Preview {
    NavigationStack {
        DashboardView()
    }
}
