//
//  RegolithInsulationView.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 23/11/24.
//
import SwiftUI

struct RegolithInsulationView: View {
    @EnvironmentObject var gameState: GameState
    @State private var pressOrder: [Int: Int] = [:] // Maps item IDs to press order
    @State private var pressCount = 0 // Tracks number of selections
    
    @State private var goProgressView = false
    @EnvironmentObject var buildingManager: BuildingManager
    @AppStorage("day") var day = 1
    @State private var neededRegolith = 30
    @State private var showAlert = false
    @AppStorage("structure") var goodStructure = true // Defaults to true
    
    @StateObject private var itemManager = ItemManager()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: ProgressBuilding(), isActive: $goProgressView) {
                EmptyView()
            }
            ZStack {
                Image("moon surface img")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                HStack {
                    // Material requirements display
                    VStack(alignment: .leading, spacing: 20) {
                        materialRequirement(imageName: "questionmark", text: "0/\(neededRegolith)")
             
                    }
                    
                    Spacer()
                    
                    // Material selection buttons
                    VStack {
                        Text("Choose 4 wisely")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(itemManager.items.indices, id: \.self) { index in
                                materialButton(id: index, title: itemManager.items[index].name.capitalized)
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
//                    Button(action: {
//
//                    }, label: {
//                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//                    })
                    // Confirm button
                    Button(action:{
                        deductResources()
                        addResourcelToBuilding()
                        
                        
                    }, label:{
                        Text("Next")
                            .font(.title2)
                            .padding()
                            .background(canProceed ? Color.green : Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    })
                    .disabled(!canProceed)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Not enough resources"),
                            message: Text("Please scavenge for more"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .preferredColorScheme(.dark)
            }
        }
    }
    
    // Computed property to enable or disable the "Next" button
    private var canProceed: Bool {
        guard pressOrder.count == 1 else { return false }
        
        // Extract the selected material index
        if let selectedMaterialIndex = pressOrder.keys.first,
           selectedMaterialIndex < itemManager.items.count {
            let currentAmount = itemManager.items[selectedMaterialIndex].amount
            let requiredAmount = neededRegolith
            
            // Check if the selected material meets the requirement
            return currentAmount >= requiredAmount
        }
        
        // Default to false if validation fails
        return false
    }


    private func addResourcelToBuilding() {
        if let emptyBuilding = buildingManager.buildings.first(where: { $0.imageName.isEmpty }) {
            if let index = buildingManager.buildings.firstIndex(of: emptyBuilding) {
                buildingManager.buildings[index].imageName = "regolithinsulation"
            }
        }
    }
    // MARK: - Material Requirement Row
    private func materialRequirement(imageName: String, text: String) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 60, height: 60)
            Text(text)
                .font(.title)
                .foregroundColor(.white)
                .monospaced()
        }
    }
    
    // MARK: - Material Button
    private func materialButton(id: Int, title: String) -> some View {
        Button(action: {
            if let order = pressOrder[id] {
                // Deselect if already selected
                pressOrder[id] = nil
                pressCount -= 1
                // Reorder remaining selections
                pressOrder = pressOrder.mapValues { $0 > order ? $0 - 1 : $0 }
            } else if pressCount < 1{
                // Select if not already selected
                pressCount += 1
                pressOrder[id] = pressCount
            }
        }) {
            ZStack {
                Color.white
                    .cornerRadius(10)
                    .frame(height: 65)
                
                VStack {
                    Image(itemManager.items[id].name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Text("\(itemManager.items[id].amount)")
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .monospaced()
                }
                
                HStack{
                    Spacer()
                    VStack{
                        if let order = pressOrder[id] {
                            Text("\(order)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(Circle())
                            Spacer()
                        }
                    }
                   
                }
            }
        }
    }
    
    // MARK: - Deduct Resources
    private func deductResources() {
        guard canProceed else {
            showAlert = true
            return
        }
        
        let sortedPressOrder = pressOrder.sorted { $0.value < $1.value }
        let requirements = [neededRegolith]
        var matchedRequirements = 0 // Count of correctly matched materials
        
        for (index, entry) in sortedPressOrder.enumerated() {
            let materialIndex = entry.key
            let requiredAmount = requirements[index]
            itemManager.items[materialIndex].amount -= requiredAmount
            
            // Check if material matches one of the required types
            let selectedMaterial = itemManager.items[materialIndex].name.lowercased()
            if ["regolith"].contains(selectedMaterial) {
                matchedRequirements += 1
            }
        }
        
        goodStructure = matchedRequirements >= 3
        goProgressView = true
        
        // Reset selections
        pressOrder.removeAll()
        pressCount = 0
        
    }
}

#Preview{
    RegolithInsulationView()
}

