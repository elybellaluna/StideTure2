//
//  sessionStore.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/24/25.
//

import SwiftUI
import Foundation

class SessionStore: ObservableObject {
    @Published var score: Int = 0
}
struct sessionStore: View {
    var body: some View {
    }
}

#Preview {
    sessionStore()
}
