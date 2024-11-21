import SwiftUI

struct BasicShelterView: View {
    @EnvironmentObject var gameState: GameState
    @State private var pressOrder: [Int: Int] = [:] // Maps item IDs to press order
    @State private var pressCount = 0 // Tracks number of selections
    
    @State private var goProgressView = false
    @State private var neededMetal = 15
    @State private var neededPlastic = 10
    @State private var neededInsulating = 20
    @State private var neededElectronics = 3
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
                        materialRequirement(imageName: "questionmark", text: "0/\(neededMetal)")
                        materialRequirement(imageName: "questionmark", text: "0/\(neededPlastic)")
                        materialRequirement(imageName: "questionmark", text: "0/\(neededInsulating)")
                        materialRequirement(imageName: "questionmark", text: "0/\(neededElectronics)")
                    }
                    
                    Spacer()
                    
                    // Material selection buttons
                    VStack {
                        Text("Choose 4 wisely")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(itemManager.items.indices, id: \.self) { index in
                                materialButton(id: index, title: itemManager.items[index].name.capitalized)
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    // Confirm button
                    Button(action: deductResources) {
                        Text("Next")
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.green)
                    }
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
            if pressCount < 4 && pressOrder[id] == nil {
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
                
                if let order = pressOrder[id] {
                    Text("\(order)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 110, y: -25)
                }
            }
        }
        .disabled(pressOrder[id] != nil || pressCount >= 4)
    }
    
    // MARK: - Deduct Resources
    private func deductResources() {
        guard pressOrder.count == 4 else {
            showAlert = true
            return
        }
        
        // Sort by selection order
        let sortedPressOrder = pressOrder.sorted { $0.value < $1.value }
        let requirements = [neededMetal, neededPlastic, neededInsulating, neededElectronics]
        var matchedRequirements = 0 // Count of correctly matched materials
        
        for (index, entry) in sortedPressOrder.enumerated() {
            let materialIndex = entry.key
            if materialIndex < itemManager.items.count {
                // Check if there's enough resource to deduct
                let currentAmount = itemManager.items[materialIndex].amount
                if currentAmount >= requirements[index] {
                    // Deduct resources
                    itemManager.items[materialIndex].amount -= requirements[index]
                    
                    // Check if material matches one of the required types
                    let selectedMaterial = itemManager.items[materialIndex].name.lowercased()
                    if ["metal", "plastic", "insulating", "electronics"].contains(selectedMaterial) {
                        matchedRequirements += 1
                    }
                } else {
                    // Not enough resource, show alert and exit
                    showAlert = true
                    return
                }
            }
        }
        
        // Check if at least 3 materials are correctly matched
        goodStructure = matchedRequirements >= 3
        goProgressView = true
        
        // Reset selections
        pressOrder.removeAll()
        pressCount = 0
    }
}
#Preview {
    BasicShelterView()
}
