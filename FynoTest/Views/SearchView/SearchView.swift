//
//  SearchView.swift
//  FynoTest
//
//  Created by Ruslan Kuksa on 27.06.2024.
//

import SwiftUI

struct SearchView<Data: RandomAccessCollection, Label: View>: View where Data.Element: Identifiable {
    
    @Binding var query: String
    
    let data: Data
    let label: (Data.Element) -> Label
    let onSelect: (Data.Element) -> Void
    
    init(
        query: Binding<String>,
        data: Data,
        label: @escaping (Data.Element) -> Label,
        onSelect: @escaping (Data.Element) -> Void
    ) {
        self._query = query
        self.data = data
        self.label = label
        self.onSelect = onSelect
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(data) { item in
                    Button {
                        onSelect(item)
                    } label: {
                        label(item)
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity,
                                alignment: .leading
                            )
                            .background()
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Search")
            .listStyle(.plain)
            .searchable(
                text: $query,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Enter country name"
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        
                    }
                    .tint(.indigo)
                }
            }
        }
    }
}


#Preview {
    @State var query = ""
    return SearchView(query: $query, data: PreviewService.createPreviewCountries()) { country in
        Text(country.description)
    } onSelect: { country in
        debugPrint(country.description)
    }
}
