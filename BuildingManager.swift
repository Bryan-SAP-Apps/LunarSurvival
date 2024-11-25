
import SwiftUI
import Foundation
import Observation
// Item model
struct Building: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var imageName: String
}

class BuildingManager: ObservableObject {
    func clearImageNames() {
        buildings = buildings.map { building in
            var updatedBuilding = building
            updatedBuilding.imageName = ""
            return updatedBuilding
        }
        save() // Save the updated state
    }
    func canProceedWithShelterAndInsulation(goodStructure: Bool) -> Bool {
            guard goodStructure else { return false }

            // Check if buildings contain the necessary types
            let hasBasicShelter = buildings.contains { $0.imageName.contains("basicshelter") }
            let hasRegolithInsulation = buildings.contains { $0.imageName.contains("regolithinsulation") }

            return hasBasicShelter && hasRegolithInsulation
        }
    func canProceedWithSolarPanel(goodStructure: Bool) -> Bool {
            guard goodStructure else { return false }

            // Check if buildings contain the necessary types
            let hasSolarPanel = buildings.contains { $0.imageName.contains("solarpanel") }
//            let hasRegolithInsulation = buildings.contains { $0.imageName.contains("regolithinsulation") }

            return hasSolarPanel
        }
    var buildings: [Building] = [Building(name: "building1", imageName: ""),
                                 Building(name: "building2", imageName: ""),
                                 Building(name: "building3", imageName: ""),
                                 Building(name: "building4", imageName: ""),
                                 Building(name: "building5", imageName: ""),
                                 Building(name: "building6", imageName: "")] {
            didSet {
                save()
            }
        }
            
        init() {
            load()
        }
    private func getArchiveURL() -> URL {
        URL.documentsDirectory.appending(path: "buildings.json")
    }
    
    private func save() {
        let archiveURL = getArchiveURL()
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let encodedbuildings = try? jsonEncoder.encode(buildings)
        try? encodedbuildings?.write(to: archiveURL, options: .noFileProtection)
    }
    
    private func load() {
        let archiveURL = getArchiveURL()
        let jsonDecoder = JSONDecoder()
                
        if let retrievedBuildingData = try? Data(contentsOf: archiveURL),
           let buildingsDecoded = try? jsonDecoder.decode([Building].self, from: retrievedBuildingData) {
            buildings = buildingsDecoded
        }
    }
}



