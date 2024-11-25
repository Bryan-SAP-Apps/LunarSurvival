//
//  AfterEndDay.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 23/11/24.
//

import SwiftUI

struct AfterEndDay: View {
    @EnvironmentObject var buildingManager: BuildingManager
    @AppStorage("day") var day = 0
    @AppStorage("1")var building1 = ""
    @AppStorage("2")var building2 = ""
    @AppStorage("structure") var goodStructure = true
    @State private var goGood = false
    @State private var goDie = false
    
    var body: some View {
        NavigationStack{
            NavigationLink(
                destination: HomePage(), isActive: $goGood){
                    EmptyView()
                }
            NavigationLink(
                destination: DeathView(), isActive: $goDie){
                    EmptyView()
                }
            Text("Day \(day)")
            Text("Placeholder and logic")
            Button(action: {
//                switch day{
//                case 1:  if buildingManager.canProceedWithShelterAndInsulation(goodStructure: goodStructure) {
//                    goGood = true
//                } else {
//                    goDie = true
//                }
//                
//                case 2: if buildingManager.canProceedWithSolarPanel(goodStructure: goodStructure){
//                    goGood = true
//                } else {
//                    goDie = true
//                }
//                default: goDie = true
//                }
                if  buildingManager.buildings.contains { $0.imageName.contains("basicshelter")} && buildingManager.buildings.contains { $0.imageName.contains("regolithinsulation")}
                    {
                        goGood = true
                    } else {goDie = true}
            }, label: {
                Text("Next")
            })
            
        }
    }
}

#Preview {
    AfterEndDay()
}
