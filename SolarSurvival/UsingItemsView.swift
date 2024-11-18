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
    @State private var goProgressView = false
    @State private var neededMetal = 15
    @State private var neededPlastic = 10
    @State private var neededInsulating = 20
    @State private var neededElectronics = 3
    @State private var metalItem = 0
    @State private var showAlert = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var items = [
        Item(name: "metal", amount: 0),
        Item(name: "regolith", amount: 0),
        Item(name: "glass", amount: 0),
        Item(name: "rubber", amount: 0),
        Item(name: "plastic", amount: 0),
        Item(name: "electronics", amount: 0)
    ]
//    init() {
//        let titleTextAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.white,
//            .font: UIFont.boldSystemFont(ofSize: 100) // Adjust font size as needed
//        ]
//        UINavigationBar.appearance().largeTitleTextAttributes = titleTextAttributes
//    }

    var body: some View {
        
        NavigationStack{
            NavigationLink(destination: ProgressBuilding(), isActive: $goProgressView) {
                EmptyView()
            }
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
                                HStack {
                                    Image("questionmark")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                    Text(
                                    "0/\(neededMetal)")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    
                                }
                            HStack {
                                Image("questionmark")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("0/\(neededPlastic)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                            }
                            HStack {
                                Image("questionmark")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("0/\(neededInsulating)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                            }
                            HStack {
                                Image("questionmark")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("0/\(neededElectronics)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
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
                        VStack{
                            Button(action: {
                                
                                if let metal = items.firstIndex(where: { $0.name == "metal" }),
                                   let plastic = items.firstIndex(where: { $0.name == "plastic" }),
                                   let electronics = items.firstIndex(where: { $0.name == "electronics" }),
                                   let regolith = items.firstIndex(where: { $0.name == "regolith" })
                                                                {
                                    items[metal].amount -= neededMetal
                                    items[plastic].amount -= neededMetal
                                    items[electronics].amount -= neededMetal
                                    items[regolith].amount -= neededMetal
                                    if items[metal].amount < 0{
                                        showAlert = true
                                    }else{
                                        goProgressView = true
                                    }
                                }
                                
                                
                                
                            },label: {
                                Text("Next")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .foregroundColor(.green)
                            })
                            .alert(isPresented:$showAlert){
                            Alert (
                            title:Text("Something went wrong"),
                            message:Text("Not enough resources"),
                            dismissButton:. default(Text("done"))
                            )
                            }
                        }
                    }
                }
                .preferredColorScheme(.dark)
            }
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
                        .frame(height: 65)
                    
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
                            .offset(x: 110, y: -25) // Position in top-right corner
                    }
                }
            }
        .disabled(pressOrder[id] != nil || pressCount >= 4) // Disable button after it is clicked
        .navigationTitle("")
    }
}

#Preview {
    UsingItemsView()
}
