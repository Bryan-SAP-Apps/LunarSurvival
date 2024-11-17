//
//  InfrastructureBuildingChoices.swift
//  SolarSurvival
//
//  Created by Zicheng on 16/11/24.
//  Amended by Bryan Nguyen
//

import SwiftUI

struct UsingItemsView: View {
    @State private var pressOrder: [Int: Int] = [:]
    @State private var pressCount = 0
    @StateObject var itemManager = ItemManager()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            // Background Image
            Image("moon surface img")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                Text("Build the infrastructure using items")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.top, 60)  // Added padding to shift it down
                HStack {
                    // Left side: Displaying the items and their amounts
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(itemManager.items.prefix(4), id: \.name) { item in
                            HStack {
                                Text(item.name.capitalized)
                                    .foregroundColor(.white)
                                    .font(.title)
                                    
                                Text("0/\(item.amount)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                            }
                        }
                    }// Set width for the left column
                    
                    VStack {
                        Text("Choose 4 wisely")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        // 2x3 Buttons Grid
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(itemManager.items.indices, id: \.self) { index in
                                buttonWithOrder(
                                    id: index,
                                    title: itemManager.items[index].name.capitalized
                                )
                            }
                        }
                        .padding()
                    }
 
                    .padding(.leading, 0)  // Added padding to shift text to the right
                }
            }
            .preferredColorScheme(.dark)
        }
    }
    
    // Button with Order Logic
        func buttonWithOrder(id: Int, title: String) -> some View {
            Button(action: {
                // Allow pressing only if less than 4 buttons have been pressed
                if pressCount < 4 && pressOrder[id] == nil {
                    pressCount += 1
                    pressOrder[id] = pressCount
                    // Increment item amount when selected
                    itemManager.items[id].amount += 1
                }
            }) {
                ZStack {
                    Color.white
                        .cornerRadius(10)
                        .frame(height: 80)
                    
                    VStack {
                        Image(itemManager.items[id].name) // Ensure image assets match names
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text(title)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    
                    // Display the order in the top-right corner
                    if let order = pressOrder[id] {
                        Text("\(order)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x: 35, y: -35) // Position in top-right corner
                    }
                }
            }
        .disabled(pressOrder[id] != nil || pressCount >= 4) // Disable button after it is clicked
    }
}

#Preview {
    UsingItemsView()
}
