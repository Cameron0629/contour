import SwiftUI

struct BrowseClothingView: View {
    @State private var selectedItem: ClothingItem? = nil
    @State private var showOverlay: Bool = false

    struct ClothingItem: Identifiable {
        let id: Int
        let name: String
        let brand: String
        let size: String
        let cost: String
    }

    let items: [ClothingItem] = [
        ClothingItem(id: 1, name: "T-Shirt", brand: "Contour Co.", size: "M", cost: "$25"),
        ClothingItem(id: 2, name: "Jeans", brand: "Denim Brand", size: "32", cost: "$45"),
        ClothingItem(id: 3, name: "Jacket", brand: "Outerwear", size: "L", cost: "$75"),
        ClothingItem(id: 4, name: "Sneakers", brand: "FastFeet", size: "10", cost: "$60"),
        ClothingItem(id: 5, name: "Hoodie", brand: "Contour Co.", size: "M", cost: "$50"),
        ClothingItem(id: 6, name: "Cap", brand: "Headgear", size: "One Size", cost: "$20"),
        ClothingItem(id: 7, name: "Dress", brand: "ElegantWear", size: "S", cost: "$80"),
        ClothingItem(id: 8, name: "Shorts", brand: "SummerLine", size: "M", cost: "$30"),
        ClothingItem(id: 9, name: "Boots", brand: "TrailBlazer", size: "9", cost: "$90"),
        ClothingItem(id: 10, name: "Scarf", brand: "WinterWarm", size: "One Size", cost: "$15")
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Browse Clothing")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 10) // Adjustment for being inside a NavStack

                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(items) { item in
                            VStack(spacing: 5) {
                                VStack(spacing: 5) {
                                    Rectangle()
                                        .fill(Color.contourBlue.opacity(0.2))
                                        .frame(height: 120)
                                        .cornerRadius(10)
                                        .overlay(
                                            Text(item.name)
                                                .foregroundColor(.primary)
                                                .fontWeight(.bold)
                                        )

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(item.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text("Brand: \(item.brand)")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                        Text("Size: \(item.size)")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                        Text("Cost: \(item.cost)")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    }
                                    .padding(5)
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            }
                            .onTapGesture {
                                selectedItem = item
                                showOverlay = true
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity) // Ensures content fills the width
            }

            // Overlay popup
            if showOverlay, let item = selectedItem {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showOverlay = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()

                    Spacer()

                    // Popup card with adaptive background
                    VStack(spacing: 0) {
                        VStack(spacing: 5) {
                            Rectangle()
                                .fill(Color.contourBlue.opacity(0.2))
                                .frame(height: 240) // Enlarged placeholder
                                .cornerRadius(10)
                                .overlay(
                                    Text(item.name)
                                        .foregroundColor(.primary)
                                        .fontWeight(.bold)
                                        .font(.title)
                                )

                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                Text("Brand: \(item.brand)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Size: \(item.size)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Cost: \(item.cost)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                            .padding(5)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(.systemBackground)) // Adaptive background
                            .shadow(radius: 10)
                    )
                    .padding()
                    .frame(maxWidth: 350)

                    Spacer()
                }
            }
        }
        .animation(.easeInOut, value: showOverlay)
        .navigationTitle("Browse Clothing")
    }
}

struct BrowseClothingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Group {
                BrowseClothingView()
                    .preferredColorScheme(.light)
                BrowseClothingView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
