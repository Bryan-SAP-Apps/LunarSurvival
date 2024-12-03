//
//  DeathView.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 23/11/24.
//

import SwiftUI

struct DeathView: View {
    @State private var showAlert = false
    @AppStorage("day") var day = 1
    @EnvironmentObject var buildingManager: BuildingManager
    @StateObject var energyManager = EnergyManager()
    @StateObject var itemManager = ItemManager()
    @AppStorage("daysForRescue") var daysForRescue = 3
    @AppStorage("eat") var eat = 0
    var body: some View {
        NavigationStack{
            Group{
                if showAlert == true{
                    StartView()
                } else {
                    VStack(spacing: 20) {
                        Text("Game Over")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("YOU SURVIVED FOR \(day - 1) DAYS")
                      
                        Button(action: {
                            day = 1
                            showAlert = true
                            
                        }, label: {
                            Text("Restart")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        })
                        // Automatically trigger alert as soon as the view appears
                        
                    }
                    
                    //
                    .navigationBarBackButtonHidden()
                }
            }
        }
    }
    
    //struct DeathView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        DeathView(playCutscene: playCutscene)
    //    }
    //}
}
