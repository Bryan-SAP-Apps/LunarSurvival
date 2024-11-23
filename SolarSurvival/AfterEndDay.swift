//
//  AfterEndDay.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 23/11/24.
//

import SwiftUI

struct AfterEndDay: View {
    @AppStorage("day") var day = 0
    @AppStorage("1")var building1 = ""
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
                if building1.isEmpty == true || goodStructure == false {
                    goDie = true
                } else{
                    goGood = true
                }
            }, label: {
                Text("Next")
            })
            
        }
    }
}

#Preview {
    AfterEndDay()
}
