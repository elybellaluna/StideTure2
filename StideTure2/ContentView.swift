//
//  ContentView.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/9/25.
//

import SwiftUI
struct ContentView: View {
    @State private var current = 2.0
    @State private var minValue = 0.0
    @State private var maxValue = 3.0
    @State private var selectedOption = "Option 1"
    var body: some View {
        ZStack{
                //Welcome back top screen
                Text("Welcome Back")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                    .position(x:120, y:10)
                    .padding(0)
                //fetch user name for welcome back text (currently static)
                var userName: String = "John"
                Text("\(userName)!")
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 0.5137254901960784, green: 0.40784313725490196, blue: 0.7254901960784313))
                    .padding(.top, 0)
                    .position(x:70, y:45)
                
                //start stride button
                Button("Start Stride") {
                    
                }
                .padding()
                .frame(width: 298.0, height: 40)
                .background(Color(red: 0.5137254901960784, green: 0.40784313725490196, blue: 0.7254901960784313))
                .foregroundColor(.white)
                .cornerRadius(25.0)
                .position(x:200, y:300)
                
                
                
                Gauge(value: current, in: minValue...maxValue) {
                    Text("BPM")
                        .frame(width: 8.0)
                } currentValueLabel: {
                    Text("\(Int(current))")
                } minimumValueLabel: {
                    Text("\(Int(minValue))")
                } maximumValueLabel: {
                    Text("\(Int(maxValue))")
                }
                .gaugeStyle(.accessoryCircular)
                .position(x:200, y:200)
                
                Gauge(value: current, in: minValue...maxValue) {
                    Text("BPM")
                } currentValueLabel: {
                    Text("\(Int(current))")
                } minimumValueLabel: {
                    Text("\(Int(minValue))")
                } maximumValueLabel: {
                    Text("\(Int(maxValue))")
                }
                .position(x:200, y:400)
                
            
    Text("Environment: \(selectedOption)")
            Menu{
                Button("Park"){
                    selectedOption = "Park"
                }
                Button("City"){
                    selectedOption = "City"
                }
                Button("Forest"){
                    selectedOption = "Forest"
                }
            } label: {
                    Label("Select Environment", systemImage:"chevron.down.circle")
                        .background(Color.blue)
                        .cornerRadius(5)
                        .position(x:200, y:250)
                        .foregroundColor(.white)
                }
            }
        }
    }

//A5A6F6,8368B9,287886
#Preview {
    ContentView()
}
