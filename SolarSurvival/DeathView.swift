//
//  DeathView.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 23/11/24.
//

import SwiftUI

struct DeathView: View {
    @State private var showAlert = false

    var body: some View {
        VStack {
            Text("Game Screen")
                .font(.largeTitle)

            // Automatically trigger alert as soon as the view appears
            .onAppear {
                // Simulating the event that triggers the alert (e.g., player death)
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Game Over"),
                message: Text("You Died"),
                dismissButton: .destructive(Text("Restart"))
            )
        }
    }
}

struct DeathView_Previews: PreviewProvider {
    static var previews: some View {
        DeathView()
    }
}
