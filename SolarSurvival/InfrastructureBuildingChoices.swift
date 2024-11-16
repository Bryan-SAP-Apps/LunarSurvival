//
//  InfrastructureBuildingChoices.swift
//  SolarSurvival
//
//  Created by Zicheng on 16/11/24.
//


import SwiftUI

struct InfrastructureBuildingChoices: View {
    var body: some View {
        ZStack {
            // Background Color
            Color.black.ignoresSafeArea()
            
            VStack {
                // Top Text
                Text("Build a piece of infrastructure")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                // 2x3 Buttons Grid
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        Button(action: {}) {
                            Text("Choice 1")
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {}) {
                            Text("Choice 2")
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(10)
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
            VStack {
                HStack {
                    Button(action: {}) {
                        Text("Back")
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .frame(idealWidth: .infinity, idealHeight: .infinity)
        .preferredColorScheme(.dark)
    }
}

struct InfrastructureBuildingChoices_Previews: PreviewProvider {
    static var previews: some View {
        InfrastructureBuildingChoices()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
