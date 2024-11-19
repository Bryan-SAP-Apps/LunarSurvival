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
    var body: some View {
        NavigationStack{
            NavigationLink(destination: BasicShelterView(), isActive: $basicshelter) {
                EmptyView()
            }
            NavigationLink(destination: WaterFilterView(), isActive: $waterfilter) {
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
                                        .frame(maxHeight: 60)
                                    
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
                                        .frame(maxHeight: 60)
                                    
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
                            Button(action: {}) {
                                Text("Choice 3")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {}) {
                                Text("Choice 4")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                        }
                        
                        HStack(spacing: 20) {
                            Button(action: {}) {
                                Text("Choice 5")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {}) {
                                Text("Choice 6")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(10)
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

#Preview {
    InfrastructureBuildingChoices()
}
