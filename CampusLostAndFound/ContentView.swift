import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = LostFoundViewModel()

    var body: some View {
        TabView {
            ItemListView(viewModel: viewModel, isLost: true)
                .tabItem {
                    Label("Lost Items", systemImage: "magnifyingglass")
                }
            ItemListView(viewModel: viewModel, isLost: false)
                .tabItem {
                    Label("Found Items", systemImage: "checkmark.circle")
                }
            AddItemView(viewModel: viewModel)
                .tabItem {
                    Label("Add Item", systemImage: "plus.circle")
                }
        }
    }
}
