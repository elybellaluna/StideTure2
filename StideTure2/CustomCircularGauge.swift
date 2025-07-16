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
    var size: CGFloat = 150
    var progress: Double {
        (value - range.lowerBound) / (range.upperBound - range.lowerBound)}
    
    var body: some View {
//design gauge style

                            
                  Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
                        .frame(width: size, height: size)
                    
                  Circle()
                        .trim(from: 0.0, to: min(progress, 1.0))
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [.purple, .blue]),
                                center: .center
                            ),
                            style: StrokeStyle(lineWidth: lineWidth,lineCap: .round)
                            )
                        .rotationEffect(.degrees(-90))
                        .frame(width: size, height: size)
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
