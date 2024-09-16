import SwiftUI

struct ItemListView: View {
    @ObservedObject var viewModel: LostFoundViewModel
    var isLost: Bool

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items.filter { $0.isLost == isLost }) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.description)
                            .font(.subheadline)
                        Text("\(item.date, formatter: dateFormatter)")
                            .font(.caption)
                    }
                }
            }
            .navigationTitle(isLost ? "Lost Items" : "Found Items")
        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
