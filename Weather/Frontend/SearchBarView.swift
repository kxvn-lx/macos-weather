//
//  SearchBarView.swift
//  Weather
//
//  Created by Kevin Laminto on 29/3/2023.
//

import SwiftUI

struct SearchBarView: View {
    @State private var isSearching = false
    @State private var isHidden = true
    @EnvironmentObject private var vm: ContentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            KeyboardsCommandView(isHidden: $isHidden)
            
            HStack {
                Text(Date().getToday())
                    .font(.headline)
                
                Text("⌘ + F to search for a city...")
                    .font(.caption2)
                    .opacity(0.5)
            }
            
            HStack {
                if !isHidden {
                    TextField("Search...", text: $vm.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(Color.primary)
                        .onTapGesture {
                            isSearching = true
                        }
                        .onSubmit {
                            vm.onTextfieldSubmit()
                        }
                }
            }
        }
    }
}


extension SearchBarView {

}
