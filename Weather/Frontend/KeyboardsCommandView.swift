//
//  KeyboardsCommandView.swift
//  Weather
//
//  Created by Kevin Laminto on 31/3/2023.
//

import SwiftUI

private struct AlertProps {
    var isPresented = false
    var title = "Refreshed!"
    var message = ""
    
}

struct KeyboardsCommandView: View {
    @EnvironmentObject private var vm: ContentViewModel
    @Binding var isHidden: Bool
    @State private var alertProps = AlertProps()
    
    var body: some View {
        HStack {
            Button("") {
                isHidden.toggle()
            }
            .opacity(0)
            .keyboardShortcut("f")
            
            Button("") {
                vm.refresh { status in
                    guard let wd = vm.weatherData else { return }
                    alertProps.title = "Refreshed for: \(wd.address)"
                    alertProps.isPresented = true
                    alertProps.message = status ? "Finished: Successful" : "Finished: Failed"
                }
            }
            .opacity(0)
            .keyboardShortcut("r")
            .alert(alertProps.title, isPresented: $alertProps.isPresented, actions: {
            }, message: {
                Text(alertProps.message)
            })
        }
    }
    
    struct KeyboardsCommandView_Previews: PreviewProvider {
        static var previews: some View {
            KeyboardsCommandView(isHidden: .constant(false))
        }
    }
}
