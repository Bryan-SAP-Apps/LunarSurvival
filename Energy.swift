import Foundation
import SwiftUI

// MARK: - Energy Struct
struct Energy: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var amount: Double {
        didSet {
            amount = clamped(to: 0...100)
        }
    }
    
    init(name: String, amount: Double) {
        self.name = name
        self.amount = amount.clamped(to: 0...100)
    }
    
    private func clamped(to range: ClosedRange<Double>) -> Double {
        min(max(amount, range.lowerBound), range.upperBound)
    }
}

// MARK: - EnergyManager Class
class EnergyManager: ObservableObject {
    @Published var energies: [Energy] = [
        Energy(name: "Energy", amount: 100)
    ] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    // Reset all energy amounts to 100
    func clearEnergyAmount() {
        energies = energies.map { energy in
            var updatedEnergy = energy
            updatedEnergy.amount = 100
            return updatedEnergy
        }
    }
    
    // MARK: - Persistence
    private func getArchiveURL() -> URL {
        URL.documentsDirectory.appending(path: "energies.json")
    }
    
    private func save() {
        let archiveURL = getArchiveURL()
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        do {
            let encodedEnergies = try jsonEncoder.encode(energies)
            try encodedEnergies.write(to: archiveURL, options: .atomic)
        } catch {
            print("Error saving energies: \(error.localizedDescription)")
        }
    }
    
    private func load() {
        let archiveURL = getArchiveURL()
        let jsonDecoder = JSONDecoder()
        
        do {
            let retrievedEnergyData = try Data(contentsOf: archiveURL)
            let decodedEnergies = try jsonDecoder.decode([Energy].self, from: retrievedEnergyData)
            energies = decodedEnergies
        } catch {
            print("Error loading energies: \(error.localizedDescription)")
        }
    }
}

// MARK: - Extensions
extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}

