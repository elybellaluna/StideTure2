//
//  progressPage.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/9/25.
//

import SwiftUI
import Charts
import MapKit

struct DailyStat: Identifiable {
    let id = UUID()
    let day: String
    let steps: Int
    let time: Int
    let route: [CLLocationCoordinate2D]
}

struct ProgressViewPage: View {
    @State private var stats: [DailyStat] = [
        DailyStat(day: "Mon", steps: 4500, time: 32, route: sampleRoute1),
        DailyStat(day: "Tue", steps: 6200, time: 48, route: sampleRoute2),
        DailyStat(day: "Wed", steps: 3700, time: 25, route: sampleRoute1),
        DailyStat(day: "Thu", steps: 7000, time: 50, route: sampleRoute2),
        DailyStat(day: "Fri", steps: 5400, time: 36, route: sampleRoute1),
        DailyStat(day: "Sat", steps: 8300, time: 62, route: sampleRoute2),
        DailyStat(day: "Sun", steps: 3900, time: 29, route: sampleRoute1)
    ]

    var body: some View {
        TabView {
            VStack {
                Text("Weekly Steps").font(.title).bold().padding(.top)
                    .foregroundStyle(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                Chart {
                    ForEach(stats) { stat in
                        BarMark(x: .value("Day", stat.day),
                                y: .value("Steps", stat.steps))
                            .foregroundStyle(Color(red: 0.5137254901960784, green: 0.40784313725490196, blue: 0.7254901960784313))
                    }
                }
                .frame(height: 250)
                .padding()
            }
            .tag(0)

            VStack {
                Text("Active Time").font(.title).bold().padding(.top)
                    .foregroundStyle(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                Chart {
                    ForEach(stats) { stat in
                        BarMark(x: .value("Day", stat.day),
                                y: .value("Minutes", stat.time))
                        .foregroundStyle(Color(red: 0.5137254901960784, green: 0.40784313725490196, blue: 0.7254901960784313))
                    }
                }
                .frame(height: 250)
                .padding()
            }
            .tag(1)

            VStack {
                Text("Distance Map")
                    .font(.title)
                    .bold()
                    .padding(.top)
                    .foregroundStyle(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
               LineOnMapView()
            }
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

// Sample routes
let sampleRoute1: [CLLocationCoordinate2D] = [
    .init(latitude: 37.7749, longitude: -122.4194),
    .init(latitude: 37.7755, longitude: -122.4189),
    .init(latitude: 37.7762, longitude: -122.4185)
]
let sampleRoute2: [CLLocationCoordinate2D] = [
    .init(latitude: 37.7749, longitude: -122.4194),
    .init(latitude: 37.7758, longitude: -122.4202),
    .init(latitude: 37.7769, longitude: -122.4210)
]


#Preview {
    ProgressViewPage()
}
//steps, distance, time
