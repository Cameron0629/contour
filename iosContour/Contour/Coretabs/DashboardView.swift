import SwiftUI

struct DashboardView: View {
    var body: some View {
        // Removed NavigationLinks, as the TabView now handles main navigation
        VStack(spacing: 30) {
            Text("Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40) // Add some padding since it's now wrapped in a NavStack

            Text("Welcome to Contour! Use the tabs below to navigate.")
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // You can add quick action buttons here instead of navigation links
            Button("Quick Scan") {
                // Action for a quick scan
            }
            .buttonStyle(.borderedProminent)
            .tint(.contourBlue)

            Button("See Latest Look") {
                // Action to view latest item
            }
            .buttonStyle(.bordered)
            .tint(.contourPurple)


            Spacer()
        }
        .padding()
        // Adding the title here ensures it appears in the NavigationStack
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
