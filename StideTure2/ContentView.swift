//
//  ContentView.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/9/25.
//

import SwiftUI
struct ContentView: View {
    
//gauge and score tracking
    @State private var current = 2.0
    @State private var minValue = 0.0
    @State private var maxValue = 3.0
@AppStorage("selectedOption") var selectedOption: String?
@AppStorage("currentTargetImage") var currentTargetImage: String = ""
@AppStorage("allTimeScore") var AllTimeScore: Int = 0
    @State private var score: Int = 0

//vars for timer
    @State private var timeElapsed = 0
    @State private var timer: Timer? = nil
    @State private var isTimerOn = false
    @State private var showTimer = false
    
//timer formatting
    func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }
    
//set up for camera navigation
    @State private var showCapturePage = false
    @State private var selectedImageSet: [String] = []
    
    let parkImageSet = ["An Ant", "An oak Tree", "A Bee", "A Daisy"]
    let forestImageSet = ["Tree Vine", "A Mushroom", "A Rock", "Green Algae"]
    let cityImageSet = ["A Building","Street Traffic Light", "A Yellow Car", "A Stop Sign"]
    
//refresh and randomize images
    @State private var randomizedImageSet: [String] = []
    @State private var currentTabIndex: Int = 0
    func updateRandomImages() {
        randomizedImageSet = Array(selectedImageSet.shuffled().prefix(3))
        currentTabIndex = 0
    }
    func refreshCurrentImage() {
        let currentImage = randomizedImageSet[currentTabIndex]
        let availableImages = selectedImageSet.filter { !randomizedImageSet.contains($0)}
        guard !availableImages.isEmpty else { return }
        let newImage = availableImages.randomElement()!
        randomizedImageSet[currentTabIndex] = newImage
        }

//userName sign on
@AppStorage("userFirstName") var userFirstName: String = "User"
@AppStorage("isSignedIn") var isSignedIn = false
    
    var body: some View {
    
        ZStack{
            //Welcome back top screen
            Text("Welcome Back")
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                .position(x:120, y:10)
                .padding(0)
            //fetch user name for welcome back text (pulling from apple sign on or in app sign on)
            Text("\(userFirstName)!")
                .font(.system(size: 50, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.5137254901960784, green: 0.40784313725490196, blue: 0.7254901960784313))
                .padding(.top, 0)
                .position(x:85, y:45)
            
            if showTimer {
                Text("Stride Time: \(formatTime(seconds: timeElapsed))")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .position(x: 200, y: 420)
            }
            //start stride button
            Button(isTimerOn ? "Stop Stride" : "Start Stride") {
                if isTimerOn {
                    timer?.invalidate()
                    timer = nil
                    isTimerOn = false
                } else {
                    timeElapsed = 0
                    isTimerOn = true
                    showTimer = true
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in timeElapsed += 1 }
                }
            }
            .padding()
            .frame(width: 298.0, height: 40)
            .background(Color(red: 0.5137254901960784, green: 0.40784313725490196, blue: 0.7254901960784313))
            .foregroundColor(.white)
            .cornerRadius(25.0)
            .position(x:200, y:370)
           
            
            
            
//Calling Gauge Style
            CustomCircularGauge(value: current, range: minValue...maxValue)
                .position(x: 200, y: 200)
            
            
//dropdown for environment selection

            Menu{
                Button("Park"){
                    selectedOption = "Park"
                    selectedImageSet = parkImageSet
                    updateRandomImages()
                }
                Button("City"){
                    selectedOption = "City"
                    selectedImageSet = cityImageSet
                    updateRandomImages()
                }
                Button("Forest"){
                    selectedOption = "Forest"
                    selectedImageSet = forestImageSet
                    updateRandomImages()
                }
                
            } label: {
                HStack{
                    Spacer()
                    Text(selectedOption ?? "Select Environment")
                        .foregroundColor(Color.white)
                    Spacer()
                    
                    Image(systemName: "chevron.down.circle")
                    
                }
            }
            .padding(7)
            .background(Color(red: 0.6470588235294118, green: 0.6509803921568628, blue: 0.9647058823529412))
            .cornerRadius(20)
            .foregroundColor(.white)
            .frame(width: 298.0, height: 40.0)
            .position(x:200, y:330)
            
//slideshow placeholder before environment selection
            if selectedImageSet.isEmpty {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 165/255, green: 166/255, blue: 246/255, opacity: 1.0))
                    .frame(width: 200, height: 200)
                    .position(x:150, y:550)
            }
            
//Image slideshow
            TabView(selection: $currentTabIndex) {
                ForEach(Array(randomizedImageSet.enumerated()), id: \.element) {index, img in
                    Image(img)
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                }
            }
            .frame(width: 200, height: 200)
            .cornerRadius(20)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .position(x:150, y:550)
//will display name of image only if it is not empty
            if !randomizedImageSet.isEmpty {
                Text("Capture:\(randomizedImageSet[currentTabIndex])")
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                    .position(x: 150, y: 660)
            }
//camera button
            Button(action: {
                currentTargetImage = randomizedImageSet[currentTabIndex]
                showCapturePage = true})
            {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .position(x: 325, y: 550)
            .fullScreenCover(isPresented: $showCapturePage) {
                CapturePage()
            }
            Button("Sign Out") {
                isSignedIn = false
            }
            .position(x: 325, y: 20)
            
            Button(action:{ refreshCurrentImage()}) {
                Image(systemName: "arrow.clockwise.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.purple)
            }
                    .position(x: 270, y: 460)
        }
        
    }
            }

//A5A6F6,8368B9,287886
#Preview {
    ContentView()
}
