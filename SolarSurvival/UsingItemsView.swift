//
//  InfrastructureBuildingChoices.swift
//  SolarSurvival
//
//  Created by Zicheng on 16/11/24.
//


import SwiftUI

struct UsingItemsView: View {
    @State private var pressOrder: [Int: Int] = [:]
       @State private var pressCount = 0
       
    var body: some View {
        ZStack {
            Spacer()
            // Background Color
            
            
            VStack {
                // Top Text
                Text("Build the infrastructure using items")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black)
                
                
                Text("Choose 4 wisely")
                
                
                // 2x3 Buttons Grid
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        buttonWithOrder(id: 1, title: "Choice 1")
                        buttonWithOrder(id: 2, title: "Choice 2")
                    }
                    
                    HStack(spacing: 20) {
                        buttonWithOrder(id: 3, title: "Choice 3")
                        buttonWithOrder(id: 4, title: "Choice 4")
                    }
                    
                    HStack(spacing: 20) {
                        buttonWithOrder(id: 5, title: "Choice 5")
                        buttonWithOrder(id: 6, title: "Choice 6")
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
            .background(){
                Image("moon surface img")
            }
        }
       
    func buttonWithOrder(id: Int, title: String) -> some View {
        Button(action: {
            if pressOrder[id] == nil {
                pressCount += 1
                pressOrder[id] = pressCount
            }
        }) {
            Text(pressOrder[id] == nil ? title : "\(title) (\(pressOrder[id]!))")
                .fontWeight(.medium)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    UsingItemsView()
}
