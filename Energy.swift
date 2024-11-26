//
//  Energy.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 23/11/24.
//
import Foundation
import Observation
import SwiftUI

struct Energy: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var amount: Int
}


class EnergyManager: ObservableObject {
    func clearEnergyAmount() {
        energies = energies.map { energy in
            var updatedEnergy = energy
            updatedEnergy.amount = 100
            return updatedEnergy
        }
        save() // Save the updated state
    }
    var energies: [Energy] = [
        Energy(name: "Energy", amount: 100)
    ] {
        didSet {
            save()
        }
    }
        
    init() {
        load()
    }
    
    private func getArchiveURL() -> URL {
        URL.documentsDirectory.appending(path: "energies.json")
    }
    
    private func save() {
        let archiveURL = getArchiveURL()
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let encodedEnergies = try? jsonEncoder.encode(energies)
        try? encodedEnergies?.write(to: archiveURL, options: .noFileProtection)
    }
    
    private func load() {
        let archiveURL = getArchiveURL()
        let jsonDecoder = JSONDecoder()
                
        if let retrievedEnergyData = try? Data(contentsOf: archiveURL),
           let energiesDecoded = try? jsonDecoder.decode([Energy].self, from: retrievedEnergyData) {
            energies = energiesDecoded
        }
    }
}

