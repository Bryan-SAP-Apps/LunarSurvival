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
    @State private var activeAlert: ActiveAlert = .none
    @EnvironmentObject var alertViewModel: AlertViewModel
    
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
        
        
        NavigationStack{
            NavigationLink(destination: AstronautHandbookView(), isActive: $isPresented){
                EmptyView()
            }
            ZStack{
                VStack{
                    HStack{
                        ZStack{
                            ZStack{
                                Rectangle()
                                    .fill(Color(white: 0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 19))
                                    .frame(width: 540, height: 50)
                                
                                HStack{
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 68, height: 40)
                                        HStack{
                                            Image("glass")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 60)
                                            Text("\(itemManager.items[2].amount)")
                                                .font(.system(size: 10))
                                        }
                                    }
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 72, height: 40)
                                        HStack{
                                            Image("metal")
                                                .resizable()
                                                .frame(width: 20, height: 32)
                                            Text("\(itemManager.items[0].amount)")
                                                .font(.system(size: 10))
                                        }
                                        .frame(width:50)
                                    }
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 72, height: 40)
                                        HStack{
                                            Image("plastic")
                                                .resizable()
                                                .frame(width: 20, height: 30)
                                            Text("\(itemManager.items[4].amount)")
                                                .font(.system(size: 10))
                                        }
                                        .frame(width:50)
                                    }
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 72, height: 40)
                                        HStack{
                                            Image("rubber")
                                                .resizable()
                                                .frame(width: 20, height: 40)
                                            Text("\(itemManager.items[3].amount)")
                                                .font(.system(size: 10))
                                        }
                                        .frame(width:50)
                                    }
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 72, height: 40)
                                        HStack{
                                            Image("regolith")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 40)
                                            Text("\(itemManager.items[1].amount)")
                                                .font(.system(size: 10))
                                        }
                                        .frame(width:50)
                                    }
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 72, height: 40)
                                        //                                            .padding(.trailing, 92)
                                        HStack{
                                            Image("electronics")
                                                .resizable()
                                                .frame(width: 20, height: 16)
                                            Text("\(itemManager.items[5].amount)")
                                                .font(.system(size: 10))
                                            
                                        }.frame(width:50)
                                    }
                                    
                                }
                            }
                            HStack{
                                ZStack{
                                    Circle()
                                        .fill(Color(white: 0.4))
                                        .frame(width: 60)
                                    Image("inventory")
                                        .frame(width: 32)
                                    
                                }
                                Spacer()
                                Spacer()
                            }.padding(.trailing, 520)
                        }
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(white: 0.6))
                                .clipShape(RoundedRectangle(cornerRadius: 19))
                                .frame(width: 250, height: 50)
                            HStack{
                                let result = Double(energyManager.energies[0].amount) * 2
                                Image(systemName: "bolt.fill")
                                ZStack(alignment: .leading){
                                    Rectangle()
                                        .fill(Color(.white))
                                        .frame(width: 200, height: 35)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                    Rectangle()
                                        .fill(Color(.yellow))
                                        .frame(width: CGFloat(result), height: 35)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
                            }
                            
                        }
                    }.padding(.top, 92)
                    HStack{
                        HStack{
                            Button(action: {
                                isPresented = true
                            }, label: {
                               Image("manual")
                                    .resizable()
                                    .frame(width: 72, height: 72)
//                                    .padding(.top, 12)
                            })
                            Spacer()
                            Spacer()
                        }
                        .padding(.bottom, 200)
                        
                        //Squares
                        BuildingGridView()
                            .environmentObject(buildingManager)
                            .padding(.trailing, 180)
                       
                        //end of squares
                        Spacer()
                        VStack{
                            Text("Day \(day)")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.bottom, 180)
                            Spacer()
                            Spacer()
                        }
                    }
                    HStack{
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(white: 0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 21.6))
                                .frame(width: 550, height: 70)
                            HStack{
                                NavigationLink(destination: PlatformHolder()) {
                                    Text("Scavenge")
                                        .frame(width:140, height: 30)
                                        .font(.title)
                                        .bold()
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 19))
                                    
                                }
                                NavigationLink(destination: InfrastructureBuildingChoices()) {
                                    Text("Build")
                                        .frame(width:140, height: 30)
                                        .font(.title)
                                        .bold()
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 19))
                                    
                                }
                                Button(action: {
//                                    eat += toEat
//                                    if energyManager.energies[0].amount == 100{
//                                        eatenTooMuch = true
//                                    } else{
//                                        if eat > 3{
//                                            eatenTooMuch = true
//                                            toEat = 0
//                                        } else{
//                                            energyManager.energies[0].amount += 10
//                                            eatenTooMuch = false
//                                        }
//                                    }
                                    activeAlert = .alert1
                                    print("eating like a pro")
                                }, label: {
                                    Text("Eat")
                                        .frame(width:140, height: 30)
                                        .font(.title)
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
                                    .frame(width:150,height: 50)
                                    .font(.title)
                                    .bold()
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 19))
                            })
                            
                        }
                        
                        
                        
                    }.padding(.bottom, 68)
                    Spacer()
                    Spacer()
                }
                .background() {
                    Image("moon surface img")
                }
                .alert(isPresented: .constant(activeAlert == .alert1)) {
                    Alert(
                        title: Text("You are too full"),
                        message: Text("You cannot eat anymore"),
                        dismissButton: .default(Text("Ok"), action: {
                            eatenTooMuch = false
                            activeAlert = .none
                        })
                    )
                }
               
               
                .alert(isPresented: Binding<Bool>(
                    get: { (survived || rescued) && alertTriggered },
                    set: { _ in
                        alertTriggered = false // Reset only the alert flag here
                    }
                )) {
                    if rescued {
                        return Alert(
                            title: Text("Help is on the way!"),
                            message: Text("Survive for \(daysForRescue + 1) days more"),
                            dismissButton: .default(Text("Ok"), action: {
                                rescued = false // Reset rescued after dismissal
                            })
                        )
                    } else if survived {
                        return Alert(
                            title: Text("Congratulations"),
                            message: Text("You survived"),
                            dismissButton: .default(Text("Ok"), action: {
                                survived = false // Reset survived after dismissal
                            })
                        )
                    } else {
                        return Alert(
                            title: Text("Unknown"),
                            message: Text("Something unexpected happened"),
                            dismissButton: .default(Text("Ok"))
                        )
                    }
                }

            }
            .navigationBarBackButtonHidden()
            .alert(isPresented: .constant(activeAlert == .alert2)) {
                Alert(
                    title: Text("Congratulations"),
                    message: Text("You survived!"),
                    dismissButton: .default(Text("Ok"), action: {
                        survived = false
                        activeAlert = .none
                    })
                )
            }
        }
        .environmentObject(gameState)   // Inject gameState instance here to Pass GameState to child views
        .environmentObject(player) // Inject player instance here to Pass GameState to child views
    }
    func triggerSurvivedAlert() {
        survived = true
        alertTriggered = true
        
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

