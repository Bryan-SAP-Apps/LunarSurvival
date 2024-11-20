//
//  InfrastructureBuildingChoices.swift
//  SolarSurvival
//
//  Created by Zicheng on 16/11/24.
//  Amended by Bryan Nguyen
//

import SwiftUI

struct BasicShelterView: View {
    @EnvironmentObject var gameState: GameState
    @State private var pressOrder: [Int: Int] = [:]
    @State private var pressCount = 0
    
    @State private var goProgressView = false
    @State private var neededMetal = 15//15
    @State private var neededPlastic = 10//10
    @State private var neededInsulating = 20//20
    @State private var neededElectronics = 3//3
    @State private var metalItem = 0
    @State private var showAlert = false
    @State private var goodStructure = false
    @State private var clickedButtonIDs: [String] = [] // Stores IDs of clicked buttons
    
    @StateObject private var itemManager = ItemManager()

 
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
    init() {
            // Ensure large titles are enabled and custom font size is set
            UINavigationBar.appearance().prefersLargeTitles = true
            
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.boldSystemFont(ofSize: 40) // Adjust font size
            ]
            
            UINavigationBar.appearance().largeTitleTextAttributes = titleTextAttributes
        }


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
//                    Text("Build the infrastructure using items")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .multilineTextAlignment(.center)
//                        .background(Color.black.opacity(0.7))
//                        .cornerRadius(10)
//                        .padding(.top, 60)  // Added padding to shift it down
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
                                        .monospaced()
                                    
                                }
                            HStack {
                                Image("questionmark")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("0/\(neededPlastic)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .monospaced()
                                
                            }
                            HStack {
                                Image("questionmark")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("0/\(neededInsulating)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .monospaced()
                                
                            }
                            HStack {
                                Image("questionmark")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("0/\(neededElectronics)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .monospaced()
                                
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
                                    if itemManager.items[0].amount >= neededMetal && itemManager.items[4].amount >= neededPlastic &&
                                        itemManager.items[5].amount >= neededElectronics &&
                                        itemManager.items[1].amount >= neededInsulating {
                                        
                                        itemManager.items[0].amount -= neededMetal
                                        itemManager.items[4].amount -= neededPlastic
                                        itemManager.items[5].amount -= neededElectronics
                                        itemManager.items[1].amount -= neededInsulating
                                        goProgressView = true
                                    } else{
                                        showAlert = true
                                    }
                                    
//                                    print(items[metal].amount)
//                                    if items[metal].amount < 0{
//                                        showAlert = true
//                                    }else{
//                                        
//                                    }
                                
                                
                                
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
                            Button(action: {
                                print(clickedButtonIDs)
                            }, label: {
                                Text("Button")
                            })
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
                    clickedButtonIDs.append(title)
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
                        Text("\(itemManager.items[id].amount)")
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .monospaced()
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
        .navigationTitle("Build the infrastructure using items")
        .navigationBarTitleDisplayMode(.large)
    }
}


struct BasicShelterView_Previews: PreviewProvider {
    static var previews: some View {
        // Ensure GameState and Player are properly initialized
        let gameState = GameState()  // Create an instance of GameState
        let player = Player(startPosition: CGPoint(x: 200, y: 300))  // Create an instance of Player
        
        return BasicShelterView()
            .environmentObject(gameState)  // Inject GameState to the view
            .environmentObject(player)     // Inject Player to the view
    }
}
