//
//  SolarSurvivalApp.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 4/11/24.
//

import SwiftUI

@main
struct SolarSurvivalApp: App {
    // Create the ItemManager instance
    @StateObject var itemManager = ItemManager()
    @StateObject var alertViewModel = AlertViewModel()
    @StateObject var buildingManager = BuildingManager()
    @StateObject var gameState = GameState()
    @StateObject var player = Player(startPosition: CGPoint(x: 200, y: 300))// this is the
    
    init() {
        let currentItemManager = itemManager
        let currentGameState = gameState
        DispatchQueue.main.async {
            currentItemManager.setGameState(currentGameState)
        }
    }


    var body: some Scene {
        WindowGroup {
            CutsceneSlideshow()
                // Inject the ItemManager into the environment
                .environmentObject(itemManager)
                .environmentObject(buildingManager)
                .environmentObject(gameState)
                .environmentObject(player)
                .environmentObject(alertViewModel)
        }
    }
}
