//
//  MainPage.swift
//  SolarSurvival
//
//  Created by Ted Tan on 11/11/24.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var isNavigated = false // State variable to control navigation
    @State var continuee = false
    @State var start = "Start"
    
    var body: some View {
        NavigationStack {
            Color(red: 0.01, green: 0.1, blue: 0.4)
                .ignoresSafeArea()
                .overlay(
                    VStack{
                        VStack{
                            HStack{
                                Text("Lunar Survival")
                                    .font(.system(size: 50))
                                    .bold()
                                    .foregroundStyle(.white)
                                
                                Spacer()
                            }
                        }
                        
                        HStack{
                            Spacer()
                            VStack{
                                
                                // Button to navigate to the second view
                                Button(action: {
                                    isNavigated = true // Set the state to true to navigate
                                    if (continuee == false){
                                        start = "Start"
                                    } else {
                                        start = "Continue"
                                    }
                                }) {
                                    Text(start)
                                        .font(.title)
                                        .padding()
                                        .padding(.trailing, 62.5)
                                        .padding(.leading, 62.5)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    
                                }
                                
                                Button(action: {
                                    isNavigated = true // Set the state to true to navigate
                                    if (continuee == false){
                                        start = "Start"
                                    } else {
                                        start = "Continue"
                                    }
                                }) {
                                    Text("Reset")
                                        .font(.title)
                                        .padding()
                                        .padding(.trailing, 55)
                                        .padding(.leading, 60)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    
                                        
                                    
                                }
                            }
                        }
                        
                    }
                )
            
            // Programmatic NavigationLink
            NavigationLink(destination: ContentView(), isActive: $isNavigated) {
                EmptyView() // Use an empty view for the link
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
