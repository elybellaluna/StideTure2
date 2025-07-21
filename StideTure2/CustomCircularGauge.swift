//
//  CustomCircularGauge.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/16/25.
//

import SwiftUI

struct CustomCircularGauge: View {
    var value: Double
    var range: ClosedRange<Double>
    var lineWidth: CGFloat = 20
    var size: CGFloat = 200
    var progress: Double {
        (value - range.lowerBound) / (range.upperBound - range.lowerBound)}
    
    var body: some View {
//design gauge style
        //A5A6F6,8368B9,287886
                            
                  Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
                        .frame(width: size, height: size)
                    
                  Circle()
                        .trim(from: 0.0, to: min(progress, 1.0))
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [
                                            Color(red: 165/255, green: 166/255, blue: 246/255),
                                            Color(red: 131/255, green: 104/255, blue: 185/255),
                                            Color(red: 40/255,  green: 120/255, blue: 134/255)
                                        ]),
                                center: .center
                            ),
                            style: StrokeStyle(lineWidth: lineWidth,lineCap: .round)
                            )
                        .rotationEffect(.degrees(-90))
                        .frame(width: size, height: size)
                        .animation(.smooth, value: progress)
                                   
                    VStack{
                        Text("\(Int(value))")
                            .font(.title)
                            .bold()
                        Text("Items Scanned")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
    }
}

#Preview {
    CustomCircularGauge(value: 2.0, range: 0.0...3.0)}
