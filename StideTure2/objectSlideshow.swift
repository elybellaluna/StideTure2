//
//  objectSlideshow.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/16/25.
//

import SwiftUI

struct objectSlideshow: View {
    @State private var currentObject: Int = 0
    let images = ["image1", "image2", "image3"]
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    var body: some View {
        TabView(selection: $currentObject) {
            ForEach(0..<images.count, id: \.self) { index in
                Image(images[index])
                    .resizable()
                    .scaledToFill()
                    .tag(index)
            }
        }
        .frame(height: 200)
        .tabViewStyle(PageTabViewStyle())
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onReceive(timer) { _ in
            withAnimation {
                currentObject = (currentObject + 1) % images.count
            }
        }
    }
}
    #Preview {
        objectSlideshow()
    }
