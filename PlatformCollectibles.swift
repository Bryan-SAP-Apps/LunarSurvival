//
//  PlatformCollectibles.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 8/11/24.
//

import SwiftUI
import Foundation
import Observation
class GameState: ObservableObject {
    @Published var score = 0
    @Published var playerPosition = CGPoint(x: 200, y: 300)
    @Published var currentLevel: Int = 1 // Track which level/view is active
    @Published var savedPositions: [Int: CGPoint] = [:]
    
    init(){}
}
struct Platform {
    var position: CGPoint
    var size: CGSize
}

// Collectible model
struct Collectible {
    var position: CGPoint
}

import Foundation

struct Item: Identifiable, Codable, Equatable {
    var id = UUID()
    var metal: Int = 0
    var regolith: Int = 0
    var glass: Int = 0
    var plastic: Int = 0
    var rubber: Int = 0
    var electronics: Int = 0
    
}


class ItemManager: ObservableObject {
    @Published var items: [Item] = [] {
        didSet {
            save()
        }
    }

    init() {
        load()
    }

    private func getArchiveURL() -> URL {
        URL.documentsDirectory.appending(path: "items.json")
    }

    private func save() {
        let archiveURL = getArchiveURL()
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted

        if let encodedItems = try? jsonEncoder.encode(items) {
            try? encodedItems.write(to: archiveURL, options: .noFileProtection)
        }
    }

    private func load() {
        let archiveURL = getArchiveURL()
        let jsonDecoder = JSONDecoder()

        if let retrievedItemsData = try? Data(contentsOf: archiveURL),
           let itemsDecoded = try? jsonDecoder.decode([Item].self, from: retrievedItemsData) {
            items = itemsDecoded
        }
    }

    // Increment a random property of a random item
    func incrementRandomProperty() {
        guard !items.isEmpty else { return }

        // Choose a random item
        let randomIndex = Int.random(in: 0..<items.count)
        var item = items[randomIndex]

        // Randomly select a key path to increment
        let properties: [WritableKeyPath<Item, Int>] = [
            \.metal, \.regolith, \.glass, \.plastic, \.rubber, \.electronics
        ]

        if let randomProperty = properties.randomElement() {
            item[keyPath: randomProperty] += 1 // Increment the selected property
            items[randomIndex] = item // Update the item in the array
        }
    }
}

