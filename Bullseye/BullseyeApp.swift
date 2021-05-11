//
//  BullseyeApp.swift
//  Bullseye
//
//  Created by Juliana Leon on 10/20/20.
//

import SwiftUI

@main
struct BullseyeApp: App {
    var body: some Scene {
        WindowGroup {
            // ContentView()
            // Create the SwiftUI view that provides the window contents.
            NavigationView {
              ContentView()
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct BullseyeApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
