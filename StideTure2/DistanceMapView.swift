//
//  DistanceMapView.swift
//  StideTure2
//
//  Created by 54GOParticipant on 7/23/25.
//

import SwiftUI
import MapKit

struct DistanceMapView: View {
    var route: [CLLocationCoordinate2D]

    @State private var region: MKCoordinateRegion

    init(route: [CLLocationCoordinate2D]) {
        self.route = route
        let center = route.first ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        _region = State(initialValue: MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        ))
    }

    var body: some View {
        Map{
            MapPolyline(coordinates: route)
                .stroke(.blue, lineWidth: 5)
                .mapOverlayLevel(level: .aboveLabels)

            if let start = route.first {
                Marker("Start", coordinate: start)
                    .tint(.green)
            }
            if let end = route.last {
                Marker("End", coordinate: end)
                    .tint(.red)
            }
        }
        .mapControls {
            MapCompass()
            MapScaleView()
        }
        .ignoresSafeArea()
    }
}
#Preview {
    DistanceMapView(route: [
        CLLocationCoordinate2D(latitude: 37.3318, longitude: -121.8863),
        CLLocationCoordinate2D(latitude: 37.3323, longitude: -121.8858),
    ])
}

