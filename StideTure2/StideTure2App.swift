//
//  StideTure2App.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/9/25.
//

import SwiftUI

@main
struct StideTure2App: App {
    @StateObject private var score = SessionStore()
    var body: some Scene {
        WindowGroup {
            signInPage()
                .environmentObject(score)
        }
    }
}
