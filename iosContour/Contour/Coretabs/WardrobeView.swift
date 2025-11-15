import SwiftUI

struct WardrobeView: View {
    var body: some View {
        List {
            ForEach(1...5, id: \.self) { index in
                Text("Item in Wardrobe #\(index)")
            }
        }
        .navigationTitle("Your Wardrobe")
    }
}

#Preview {
    NavigationStack {
        WardrobeView()
    }
}
