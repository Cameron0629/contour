import SwiftUI

// Placeholder for custom colors used throughout the app


struct MainTabView: View {
    // State to manage which tab is currently selected (defaults to Dashboard)
    @State private var selectedTab: Tab = .dashboard

    enum Tab: String {
        case profile = "Profile"
        case dashboard = "Dashboard"
        case settings = "Settings"
        case wardrobe = "Wardrobe"
        case browseClothing = "Browse"

        var iconName: String {
            switch self {
            case .profile: return "person.crop.circle"
            case .dashboard: return "house.fill"
            case .settings: return "gear"
            case .wardrobe: return "hanger"
            case .browseClothing: return "tshirt.fill"
            }
        }
    }

    var body: some View {
        // TabView creates the persistent bottom bar
        TabView(selection: $selectedTab) {
            
            // 1. Dashboard Tab
            NavigationStack {
                DashboardView()
            }
            .tag(Tab.dashboard)
            .tabItem {
                Label(Tab.dashboard.rawValue, systemImage: Tab.dashboard.iconName)
            }

            // 2. Wardrobe Tab
            NavigationStack {
                WardrobeView()
            }
            .tag(Tab.wardrobe)
            .tabItem {
                Label(Tab.wardrobe.rawValue, systemImage: Tab.wardrobe.iconName)
            }

            // 3. Browse Clothing Tab
            NavigationStack {
                BrowseClothingView()
            }
            .tag(Tab.browseClothing)
            .tabItem {
                Label(Tab.browseClothing.rawValue, systemImage: Tab.browseClothing.iconName)
            }
            
            // 4. Profile Tab
            // Note: ProfileView already contains a NavigationView, but for consistency
            // and to allow deep linking within the tab, we wrap it in a NavigationStack.
            NavigationStack {
                ProfileView()
            }
            .tag(Tab.profile)
            .tabItem {
                Label(Tab.profile.rawValue, systemImage: Tab.profile.iconName)
            }
            
            // 5. Settings Tab
            NavigationStack {
                SettingsView()
            }
            .tag(Tab.settings)
            .tabItem {
                Label(Tab.settings.rawValue, systemImage: Tab.settings.iconName)
            }
        }
        .tint(.contourPurple) // Sets the accent color for the selected tab item
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
