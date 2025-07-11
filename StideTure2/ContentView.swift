//
//  ContentView.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
                    VStack {
                        //Welcome back top screen
                        Text("Welcome Back")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                            .position(x:120, y:10)
                            .padding(0)
                        //fetch user name for welcome back text (currently static)
                        let userName: String = "John7"
                        Text("\(userName)!")
                            .font(.system(size: 50, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.5137254901960784, green: 0.40784313725490196, blue: 0.7254901960784313))
                            .padding(.leading)
                            .position(x:84, y:-350)
                    }
                    //start stride button
                    Button("Start Stride") {
                        
                    }
                    .padding(.all)
                    .frame(width: 300.0)
                    .background(Color(red: 0.5137254901960784, green: 0.40784313725490196, blue: 0.7254901960784313))
                    .foregroundColor(.white)
                    .cornerRadius(25.0)
            
                }
                
            }
            
        }
    

    

    
    
    
    
    
    
    
    
    #Preview {
        ContentView()
    }
