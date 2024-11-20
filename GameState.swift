//
//  GameState.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 19/11/24.
//

import Foundation
import CoreGraphics

// Game State
class GameState: ObservableObject {
    @Published var score: Int = 0
    @Published var currentLevel: Int = 1 // Track which level/view is active
    @Published var savedPositions: [Int: CGPoint] = [:] // Save player positions for each level
    @Published var energyBar: Int = 100 // Tracks the player's energy

    @Published var inventory: [String: Int] = [:] // Inventory dictionary to track item types and amounts
    // Add the totalLevels property
    var totalLevels: Int = 5 // Set this to the total number of levels in your game
    
    // MARK: - Reset Game State
    func reset() {
        score = 0
        currentLevel = 1
        inventory.removeAll()
    }

    // MARK: - Score and Inventory Management
    func addToScore(_ points: Int) {
        score += points
    }

    func addItemToInventory(_ item: String) {
        inventory[item, default: 0] += 1
    }
    
    func resetGameState() {
        score = 0
        inventory.removeAll()
        energyBar = 100
    }

    // MARK: - Save and Load Progress (including player position)
    func saveProgress(player: Player) {
        // Save score, inventory, and player position
        UserDefaults.standard.set(score, forKey: "score")
        UserDefaults.standard.set(inventory, forKey: "inventory")
        savePlayerPosition(player.position)  // Save player position as a dictionary
    }

    func loadProgress(player: Player) {
        if let savedScore = UserDefaults.standard.value(forKey: "score") as? Int {
            score = savedScore
        }
        if let savedInventory = UserDefaults.standard.value(forKey: "inventory") as? [String: Int] {
            inventory = savedInventory
        }
        if let savedPlayerPosition = loadPlayerPosition() {
            player.position = savedPlayerPosition // Load the saved position into Player
        }
    }

    // MARK: - Helper Methods for Saving and Loading Player Position
    private func savePlayerPosition(_ position: CGPoint) {
        // Convert CGPoint to dictionary and save to UserDefaults
        let positionDict: [String: CGFloat] = [
            "x": position.x,
            "y": position.y
        ]
        UserDefaults.standard.set(positionDict, forKey: "playerPosition")
    }

    private func loadPlayerPosition() -> CGPoint? {
        // Load the player position from UserDefaults and convert back to CGPoint
        if let positionDict = UserDefaults.standard.dictionary(forKey: "playerPosition"),
           let x = positionDict["x"] as? CGFloat,
           let y = positionDict["y"] as? CGFloat {
            return CGPoint(x: x, y: y)
        }
        return nil
    }
}
