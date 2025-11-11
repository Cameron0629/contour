import SwiftUI

struct WardrobeView: View {
    var body: some View {
        VStack {
            Text("Wardrobe")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            // Add some content structure for the view
            List {
                ForEach(1...5, id: \.self) { index in
                    Text("Item in Wardrobe #\(index)")
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Your Wardrobe")
    }
}

struct WardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WardrobeView()
        }
    }
}
