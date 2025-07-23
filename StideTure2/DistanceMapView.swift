//
//  DistanceMapView.swift
//  StideTure2
//
//  Created by 54GOParticipant on 7/23/25.
//

import SwiftUI
import MapKit

struct LineOnMapView: View {
    /// The provided walking route
    let walkingRoute: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 40.836456,longitude: 14.307014),
        CLLocationCoordinate2D(latitude: 40.835654,longitude: 14.304346),
        CLLocationCoordinate2D(latitude: 40.836478,longitude: 14.302593),
        CLLocationCoordinate2D(latitude: 40.836936,longitude: 14.302464)
    ]
    
    var body: some View {
        Map {
            /// The Map Polyline map content object
            MapPolyline(coordinates: walkingRoute)
                .stroke(.blue, lineWidth: 5)
        }
    }
}
#Preview {
    LineOnMapView()
}
