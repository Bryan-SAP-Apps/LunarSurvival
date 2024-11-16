//
//  PlatformCollectibles.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 8/11/24.
//

import SwiftUI

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

