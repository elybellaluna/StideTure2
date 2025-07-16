//
//  tabBar.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/15/25.
//

import SwiftUI

struct tabBar: View {
    var body: some View {
       TabView {
            ContentView()
               .tabItem {
                   Image(systemName: "house")
                   Text("Home")
               }
           progressPage()
               .tabItem {
                   Image(systemName: "person.crop.circle")
                   Text("Progress")
               }
          badgesPage()
               .tabItem {
                   Image(systemName: "bell")
                   Text("Badges")
               }
        
        }
    }
}

#Preview {
    tabBar()
}
