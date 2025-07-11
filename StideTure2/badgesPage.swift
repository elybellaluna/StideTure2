//
//  badgesPage.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/9/25.
//

import SwiftUI

struct badgesPage: View {
    var body: some View {
        ZStack {
            VStack {
                //Badges top screen
                Text("Badges")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                    .position(x: 100, y: 40)
            }
        }
            
        }
    }
    
    #Preview {
        badgesPage()
    }

