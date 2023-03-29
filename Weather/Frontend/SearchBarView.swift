//
//  SearchBarView.swift
//  Weather
//
//  Created by Kevin Laminto on 29/3/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @State private var isSearching = false
    @Binding var isHidden: Bool
    
    var body: some View {
        HStack {
            if !isHidden {
                TextField("Search...", text: $searchText)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .onTapGesture {
                        isSearching = true
                    }
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 1)
                            
                            if isSearching {
                                Button(action: {
                                    searchText = ""
                                    isSearching = false
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                })
                                .padding(.trailing, 8)
                            }
                        }
                    )
            }
        }
    }
}
