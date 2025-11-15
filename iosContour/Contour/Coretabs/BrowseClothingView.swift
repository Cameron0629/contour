import SwiftUI

struct BrowseClothingView: View {
    @State private var selectedItem: ClothingItem?
    @State private var showOverlay = false

    struct ClothingItem: Identifiable {
        let id: Int
        let name: String
        let brand: String
        let size: String
        let cost: String
    }

    private let items: [ClothingItem] = [
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

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items) { item in
                        ClothingCard(item: item) {
                            selectedItem = item
                            showOverlay = true
                        }
                    }
                }
                .padding()
            }

            if showOverlay, let item = selectedItem {
                overlayView(item: item)
            }
        }
        .animation(.easeInOut, value: showOverlay)
        .navigationTitle("Browse Clothing")
    }
    
    private func overlayView(item: ClothingItem) -> some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    showOverlay = false
                }

            VStack {
                HStack {
                    Spacer()
                    Button {
                        showOverlay = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .padding()

                Spacer()

                ClothingCard(item: item, isLarge: true)
                    .frame(maxWidth: 350)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 10)
                    )
                    .padding()

                Spacer()
            }
        }
    }
}

struct ClothingCard: View {
    let item: BrowseClothingView.ClothingItem
    let isLarge: Bool
    let action: () -> Void
    
    init(item: BrowseClothingView.ClothingItem, isLarge: Bool = false, action: @escaping () -> Void = {}) {
        self.item = item
        self.isLarge = isLarge
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Rectangle()
                .fill(Color.contourBlue.opacity(0.2))
                .frame(height: isLarge ? 240 : 120)
                .cornerRadius(10)
                .overlay(
                    Text(item.name)
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                        .font(isLarge ? .title : .body)
                )

            VStack(alignment: .leading, spacing: isLarge ? 4 : 2) {
                Text(item.name)
                    .font(isLarge ? .title2 : .headline)
                    .fontWeight(isLarge ? .bold : .regular)
                    .foregroundColor(.primary)
                Text("Brand: \(item.brand)")
                    .font(isLarge ? .headline : .subheadline)
                    .foregroundColor(.primary)
                Text("Size: \(item.size)")
                    .font(isLarge ? .headline : .subheadline)
                    .foregroundColor(.primary)
                Text("Cost: \(item.cost)")
                    .font(isLarge ? .headline : .subheadline)
                    .foregroundColor(.green)
            }
            .padding(5)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
        .onTapGesture(perform: action)
    }
}

#Preview {
    NavigationStack {
        BrowseClothingView()
    }
}
