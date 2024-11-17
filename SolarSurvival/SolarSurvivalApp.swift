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

    var body: some Scene {
        WindowGroup {
            CutsceneSlideshow()
                // Inject the ItemManager into the environment
                .environmentObject(itemManager)
        }
    }
}
