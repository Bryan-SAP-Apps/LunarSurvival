import Foundation
import SwiftUI

// Item model
struct Building: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var imageName: String
}

class BuildingManager: ObservableObject {
    @Published var buildings: [Building] // Corrected property name and removed erroneous implementation
    
    init() {
        // Default buildings
        buildings = [
            Building(name: "building1", imageName: ""),
            Building(name: "building2", imageName: ""),
            Building(name: "building3", imageName: ""),
            Building(name: "building4", imageName: ""),
            Building(name: "building5", imageName: ""),
            Building(name: "building6", imageName: "")
        ]
    }
}


