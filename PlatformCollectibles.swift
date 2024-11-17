import SwiftUI
import Foundation

// Extension for documents directory
extension URL {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

// Game State
class GameState: ObservableObject {
    @Published var score = 0
    @Published var playerPosition = CGPoint(x: 200, y: 300)
    @Published var currentLevel: Int = 1 // Track which level/view is active
    @Published var savedPositions: [Int: CGPoint] = [:]
}

// Platform
struct Platform {
    var position: CGPoint
    var size: CGSize
}

// Collectible model
struct Collectible {
    var position: CGPoint
}

// Item model
struct Item: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var amount: Int
}

// Item Manager
class ItemManager: ObservableObject {
    @Published var items: [Item] {
        didSet {
            save() // Ensure items are saved when updated
        }
    }

    init() {
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
            print("Saved items to file: \(archiveURL)") // Debug
        } catch {
            print("Failed to save items to file: \(error)")
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
            print("Failed to load items: \(error)")
        }
    }
    
    // Increment a random property of a random item
    func addRandomItemAmount() {
        guard !items.isEmpty else { return }
        let randomIndex = Int.random(in: 0..<items.count)
        items[randomIndex].amount += 1
    }
}
