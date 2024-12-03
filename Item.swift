//
//  Item.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 19/11/24.
//

import Foundation
import SwiftUI
// Item model
struct Item: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var amount: Int = 0 
}

// Item Manager
class ItemManager: ObservableObject {
    func resetItemAmounts() {
        for index in items.indices {
            items[index].amount = 0
        }
        save() // Save the updated items to persist changes
    }
    @Published var items: [Item] {
        didSet {
            save() // Ensure items are saved when updated
        }
    }
    private var gameState: GameState?
    var totalItemAmount: Int {
            items.reduce(0) { $0 + $1.amount }
        }
    init(gameState: GameState? = nil) {
            self.gameState = gameState
        
        // Default items
        items = [
            Item(name: "metal", amount: 0),
            Item(name: "regolith", amount: 0),
            Item(name: "glass", amount: 0),
            Item(name: "rubber", amount: 0),
            Item(name: "plastic", amount: 0),
            Item(name: "electronics", amount: 0)
        ]
        
        let archiveURL = getArchiveURL()
        if FileManager.default.fileExists(atPath: archiveURL.path) {
            load() // Load items if the file exists
        } else {
            save() // Save default items if no file exists
        }
    }
    
    // Helper function to get the file URL
    private func getArchiveURL() -> URL {
        URL.documentsDirectory.appendingPathComponent("items.json")
    }
    
    // Save items to the file
    private func save() {
        let archiveURL = getArchiveURL()
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        do {
            let encodedItems = try jsonEncoder.encode(items)
            try encodedItems.write(to: archiveURL, options: .noFileProtection)
        } catch {
        }
    }
    
    // Load items from the file
    private func load() {
        let archiveURL = getArchiveURL()
        let jsonDecoder = JSONDecoder()
        
        do {
            let retrievedItemData = try Data(contentsOf: archiveURL)
            items = try jsonDecoder.decode([Item].self, from: retrievedItemData)
        } catch {
        }
    }
    func setGameState(_ gameState: GameState) {
           self.gameState = gameState
       }
    // Increment a random property of a random item
    func addRandomItemAmount() {
        guard !items.isEmpty else { return }
        
        // Distribute 5 units across random items
        var totalIncrease = 10
        while totalIncrease > 0 {
            let randomIndex = Int.random(in: 0..<items.count)
            let increase = min(1, totalIncrease) // Add 1 to a random item (or the remaining total if less than 1)
            items[randomIndex].amount += increase
            totalIncrease -= increase
        }
        // Select a random item from the list of items
        let randomItem = items.randomElement()
            
        // Ensure that the item exists before adding it to the inventory
        if let randomItem = items.randomElement() {
                    gameState?.addItemToInventory(randomItem.name)
                    gameState?.addToScore(10)
        }
       
    }

}
