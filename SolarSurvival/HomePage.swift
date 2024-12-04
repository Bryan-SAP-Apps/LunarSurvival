//
//  GameMain.swift
//  SolarSurvival
//
//  Created by Ted Tan on 14/11/24.
//

import SwiftUI
struct HomePage: View {
    @StateObject var itemManager = ItemManager()
    @EnvironmentObject var buildingManager: BuildingManager
    @StateObject var alertManager = AlertManager()
    @State private var alertData: AlertData?
    @State private var showCutscene = false
    @AppStorage("eat") var eat = 0
    @State private var toEat = 1
    @State private var eatenTooMuch = false
    @State private var isPresented = false
    @State private var showAlert = false
    @State private var afterEnd = false
    @AppStorage("day") var day = 1
    @StateObject var energyManager = EnergyManager()
    @AppStorage("survived") var survived = false
    @State private var alertTriggered = false
    @AppStorage("rescue") var rescued = false
    @AppStorage("daysForRescue") var daysForRescue = 3
    @AppStorage("justDied") var justDied = false
    @State private var dayOrDays = "DAY"
    
    
    var items = [
        Item(name: "metal", amount: 0),
        Item(name: "regolith", amount: 0),
        Item(name: "glass", amount: 0),
        Item(name: "rubber", amount: 0),
        Item(name: "plastic", amount: 0),
        Item(name: "electronics", amount: 0)
    ]
    var energies = [
        Energy(name: "Energy", amount: 100)
    ]
    
    @EnvironmentObject var gameState: GameState// this is the original
    
    //In the parent view (where you create and provide the Player instance), use .environmentObject to inject it into the environment.
    @EnvironmentObject var player: Player
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                NavigationLink(destination: AstronautHandbookView(), isActive: $isPresented) {
                    EmptyView()
                }
                ZStack {
                    Image("moon surface img")
                        .resizable()
                        .ignoresSafeArea()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    VStack {
                        Spacer()
                        HStack {
                            
                            ZStack {
                                // Adjust widths based on screen size
                                Rectangle()
                                    .fill(Color(white: 0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                    .frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.15)
                                // Adjust proportionally
                                
                                HStack {
                                    ZStack{
                                        Circle()
                                            .fill(Color(white: 0.4))
                                            .frame(width: geometry.size.width * 0.1)
                                        Image("inventory")
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                        
                                    }
                                    ForEach(0..<6, id: \.self) { index in
                                        ZStack {
                                            Rectangle()
                                                .fill(Color(white: 0.8))
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                                .frame(width: geometry.size.width * 0.08, height: geometry.size.height * 0.15) // Proportional width
                                            HStack {
                                                Image("\(itemManager.items[index].name)") 
                                                    .resizable()
                                                    .frame(width: geometry.size.width * 0.04, height: geometry.size.height * 0.05) //
                                                    
                                                Text("\(itemManager.items[index].amount)")
                                                    .font(.system(size: geometry.size.width > 1024 ? 20 : 10))
                                            }
                                        }
                                    }
                                }
                            }
                            ZStack{
                                
                                Rectangle()
                                    .fill(Color(white: 0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                    .frame(width: geometry.size.width * 0.335, height: geometry.size.height * 0.15)
                                HStack{
                                    let result = Double(energyManager.energies[0].amount) * 2
                                    
                                    Image("bolt")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.04, height: geometry.size.width * 0.04)
                                    ZStack(alignment: .leading){
                                        Rectangle()
                                            .fill(Color(.white))
                                            .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.1)
                                            .clipShape(RoundedRectangle(cornerRadius: 40))
                                        Rectangle()
                                            .fill(Color(.yellow))
                                            .frame(width: CGFloat(result) * geometry.size.width * 0.0013, height: geometry.size.height * 0.1)
                                            .clipShape(RoundedRectangle(cornerRadius: 40))
                                    }
                                }
                                
                            }
                        }
                        Spacer()
                        // Dynamic grid view
                        HStack {
                            VStack{
                                Button(action: {
                                    isPresented = true
                                }, label: {
                                    Image("manual")
                                        .resizable()
                                        .frame(width: geometry.size.height * 0.2, height: geometry.size.height * 0.2)
                                })
                                Spacer()
                                
                            }
                            
                            BuildingGridView()
                                .environmentObject(buildingManager)
                                .frame(width: geometry.size.width * 0.7)
                            
                            
                            VStack {
                                Text("Day \(day)")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                Spacer()
                            }
                        }
                        
                        // Buttons
                        Spacer()
                        HStack {
                            ZStack {
                                Rectangle()
                                
                                    .fill(Color(white: 0.7))
                                    .frame(width: geometry.size.width * 0.78, height: geometry.size.height * 0.15)
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                
                                HStack {
                                    NavigationLink(destination: PlatformHolder()) {
                                        Text("Scavenge")
                                            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05)
                                            .font(.title2)
                                            .bold()
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 19))
                                    }
                                    NavigationLink(destination: InfrastructureBuildingChoices()) {
                                        Text("Build")
                                            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05)
                                            .font(.title2)
                                            .bold()
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 19))
                                    }
                                    Button(action:{
                                        eat += toEat
                                        if energyManager.energies[0].amount == 100{
                                            alertManager.triggerAlert(title: "You are too full", message: "You cannot eat anymore")
                                        } else{
                                            if eat > 3{
                                                alertManager.triggerAlert(title: "You are too full", message: "You cannot eat anymore")
                                                toEat = 0
                                            } else{
                                                energyManager.energies[0].amount += 10
                                                eatenTooMuch = false
                                            }
                                        }
                                        
                                    },
                                           label: {
                                        Text("Eat")
                                            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05)
                                            .font(.title2)
                                            .bold()
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 19))
                                    })
                                }
                            }
                            NavigationLink(destination: DayTransitionCutscene( onFinish: {}), isActive: $showCutscene) {
                                Button(action: {
                                    afterEnd = true
                                    showCutscene = true
                                    survived = false
                                    rescued = false
                                    energyManager.energies[0].amount += 50
                                }
                                       , label: {
                                    Text("End Day")
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.1)
                                        .font(.title2)
                                        .bold()
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 19))
                                })
                                
                            }
                            
                        }
                    }
                    .background {
                        Image("moon surface img")
                            .resizable()
                            .ignoresSafeArea()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .alert(
                        alertManager.alertTitle,
                        isPresented: $alertManager.isAlertPresented
                    ) {
                        Button("OK", role: .cancel) {
                            alertManager.resetAlert()
                        }
                    } message: {
                        Text(alertManager.alertMessage)
                    }
                    
                }
                .navigationBarBackButtonHidden()
                .onAppear(perform: {
                    if justDied == true{
                        day = 1
                    }
                    if survived == true{
                        alertManager.triggerAlert(title: "Congratulations", message: "You survived")
                        survived = false
                    }
                    if rescued == true{
                        alertManager.triggerAlert(title: "Help is on the way!", message: "Survive for \(daysForRescue + 1) \(dayOrDays) more")
                        rescued = false
                    }
                    if daysForRescue + 1 == 1{
                        dayOrDays = "day"
                    } else{
                        dayOrDays = "days"
                    }
                })
                //            .alert(isPresented: .constant(activeAlert == .alert2)) {
                //                Alert(
                //                    title: Text("Congratulations"),
                //                    message: Text("You survived!"),
                //                    dismissButton: .default(Text("Ok"), action: {
                //                        survived = false
                //                        activeAlert = .none
                //                    })
                //                )
                //            }
            }
            .environmentObject(gameState)   // Inject gameState instance here to Pass GameState to child views
            .environmentObject(player) // Inject player instance here to Pass GameState to child views
        }
    }
}




struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        // Test with just a basic setup for HomePage
        HomePage()
            .environmentObject(GameState()) // Test if GameState can be injected
            .environmentObject(Player(startPosition: CGPoint(x: 200, y: 300)))
            .environmentObject(BuildingManager())// Test if Player can be injected
    }
}

