//
//  CongratView.swift
//  SolarSurvival
//
//  Created by T Krobot on 15/11/24.
//
import SwiftUI
import SDWebImageSwiftUI

struct CongratView: View {
    @State private var isNavigated = false // State variable to control navigation
    @State var continuee = false
    @State var start = "Start"
    @State var days = 5
    @State var infra = 4
    @State var resources = 22
    @State var distance = 10
    @State var isAnimated = true
    
    
    var body: some View {
        NavigationStack {
            Color(red: 0.01, green: 0.10, blue: 0.40)
                .ignoresSafeArea()
                .overlay(
                    ZStack{
                        
                    VStack{
                        Text("Congratulations!")
                            .font(.system(size: 50))
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                        
                        VStack{
                            HStack{
                                VStack{
                                    
                                    
                                    Text("Days survived: \(days)")
                                        .font(.title2)
                                    
                                        .foregroundColor(.white)
                                        .padding()
                                    
                                    Text("Infrastructure built: \(infra)")
                                        .font(.title2)
                                    
                                        .foregroundColor(.white)
                                    Spacer()
                                    
                                }
                                Spacer()
                                VStack{
                                    
                                    
                                    Text("Total resources \n collected: \(resources)")
                                        .font(.title2)
                                    
                                        .foregroundColor(.white)
                                        .padding()
                                    
                                    Text("Total distance traveled \n while scavenging: \(distance)km")
                                        .font(.title2)
                                    
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                        }
                        Spacer()
                        HStack{
                        Spacer()
                        Button(action: {
                            isNavigated = true // Set the state to true to navigate
                            if (continuee == false){
                                start = "Start"
                            } else {
                                start = "Continue"
                            }
                        }) {
                            Text("Restart game")
                                .font(.title)
                                .padding()
                                .padding(.trailing, 20)
                                .padding(.leading, 20)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            
                            
                        }
                    }
                    }
                        VStack{
                            
                            AnimatedImage(name: "Rocket on earthidk.png", isAnimating: $isAnimated)
                                .resizable()
                                .scaledToFit()
                                
                    }
                    }
                )
            
            // Programmatic NavigationLink
            //NavigationLink(destination: ContentView(), isActive: $isNavigated) {
              //  EmptyView() // Use an empty view for the link
            //}
        }
    }
}

#Preview {
    CongratView()
}
