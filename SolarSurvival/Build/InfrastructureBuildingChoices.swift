//
//  InfrastructureBuildingChoices.swift
//  SolarSurvival
//
//  Created by Zicheng on 16/11/24.
//


import SwiftUI

struct InfrastructureBuildingChoices: View {
    @State private var basicshelter = false
    @State private var waterfilter = false
    @State private var solarpanel = false
    @State private var co2filter = false
    @State private var regolithinsulation = false
    @State private var highgainantenna = false
    var body: some View {
        NavigationStack{
            NavigationLink(destination: BasicShelterView(), isActive: $basicshelter) {
                EmptyView()
            }
            NavigationLink(destination: WaterFilterView(), isActive: $waterfilter) {
                EmptyView()
            }
            NavigationLink(destination: SolarPanelView(), isActive: $solarpanel) {
                EmptyView()
            }
            NavigationLink(destination: CO2FilterView(), isActive: $co2filter) {
                EmptyView()
            }
            NavigationLink(destination: RegolithInsulationView(), isActive: $regolithinsulation) {
                EmptyView()
            }
            NavigationLink(destination: HighGainAntennaView(), isActive: $highgainantenna) {
                EmptyView()
            }
            ZStack {
                
                Spacer()
                // Background Color
                
                
                VStack {
                    // Top Text
                    Text("Build a piece of infrastructure")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 14)
                        .padding(.all, 2)
                        .background(.black)
                    
                    
                    VStack(spacing: 20) {
                        HStack(spacing: 20) {
                            Button(action: {
                                basicshelter = true
                            }) {
                                ZStack {
                                    Color.white // Background color
                                        .cornerRadius(10)
                                        .frame(maxHeight: 76)
                                    
                                    HStack {
                                        Image("basicshelter")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)// Adjust size as needed
                                        Text("Basic Shelter")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            Button(action: {
                                waterfilter = true
                            }) {
                                ZStack {
                                    Color.white // Background color
                                        .cornerRadius(10)
                                        .frame(maxHeight: 76)
                                    
                                    HStack {
                                        Image("waterfilter")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)// Adjust size as needed
                                        Text("Water Filter")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                solarpanel = true
                            }) {
                                ZStack {
                                    Color.white // Background color
                                        .cornerRadius(10)
                                        .frame(maxHeight: 76)
                                    
                                    HStack {
                                        Image("solarpanel")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)// Adjust size as needed
                                        Text("Solar Panel")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            Button(action: {
                                co2filter = true
                            }) {
                                ZStack {
                                    Color.white // Background color
                                        .cornerRadius(10)
                                        .frame(maxHeight: 76)
                                    
                                    HStack {
                                        Image("co2filter")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)// Adjust size as needed
                                        Text("CO2 Filter")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                regolithinsulation = true
                            }) {
                                ZStack {
                                    Color.white // Background color
                                        .cornerRadius(10)
                                        .frame(maxHeight: 76)
                                    
                                    HStack {
                                        Image("regolithinsulation")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)// Adjust size as needed
                                        Text("Regolith Insulation")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            Button(action: {
                                highgainantenna = true
                            }) {
                                ZStack {
                                    Color.white // Background color
                                        .cornerRadius(10)
                                        .frame(maxHeight: 76)
                                    
                                    HStack {
                                        Image("highgainantenna")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)// Adjust size as needed
                                        Text("High Gain Antenna")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                
                // Top Left "Back" Button
//                VStack {
//                    HStack {
//                        Button(action: {}) {
//                            Text("Back")
//                                .fontWeight(.medium)
//                                .foregroundColor(.black)
//                                .padding()
//                                .background(Color.gray)
//                                .cornerRadius(10)
//                        }
//                        Spacer()
//                    }
//                    Spacer()
//                }
//                .padding()
            }
            .frame(idealWidth: .infinity, idealHeight: .infinity)
            .preferredColorScheme(.dark)
           
            .background(){
                Image("moon surface img")
            }
        }
    }
}



struct InfrastructureBuildingChoices_Previews: PreviewProvider {
    static var previews: some View {
        // Ensure GameState and Player are properly initialized
        let gameState = GameState()  // Create an instance of GameState
        let player = Player(startPosition: CGPoint(x: 200, y: 300))  // Create an instance of Player
        
        return InfrastructureBuildingChoices()
            .environmentObject(gameState)  // Inject GameState to the view
            .environmentObject(player)     // Inject Player to the view
    }
}
