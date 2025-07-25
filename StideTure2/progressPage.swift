//
//  progressPage.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/9/25.
//

import SwiftUI
import Charts
import MapKit

struct ProgressPage: View {
    @StateObject var viewModel = ProgressViewModel()
    @State private var selectedTab = 0

    // Sample route
    let sampleRoute = [
        CLLocationCoordinate2D(latitude: 41.838282, longitude: -87.628591),
        CLLocationCoordinate2D(latitude: 41.838432, longitude: -87.621531)
    ]

    var body: some View {
        VStack {
            Text("Progress")
                .font(.largeTitle)
                .bold()
                .padding(.top)
                .padding(.leading , -170)
                .foregroundStyle(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))

            TabView(selection: $selectedTab) {
                // Steps chart
                ChartView(title: "Steps", data: viewModel.steps, color: .green)
                    .tag(0)

                // Time chart
                ChartView(title: "Exercise Minutes", data: viewModel.time, color: .orange)
                    .tag(1)

                // Distance Map
                DistanceMapView(route: sampleRoute)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onAppear {
                viewModel.loadWeeklyData()
            }
        }
    }
}

struct ChartView: View {
    let title: String
    let data: [Double]
    let color: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.bottom, 5)

            Chart {
                ForEach(Array(data.enumerated()), id: \.offset) { index, value in
                    BarMark(
                        x: .value("Day", index),
                        y: .value(title, value)
                    )
                    .foregroundStyle(color)
                }
            }
            .frame(height: 220)
            .padding()
        }
        .padding()
    }
}

#Preview {
    ProgressPage()
}
//steps, distance, time
