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
    
    
    @State private var showCutscene = false
    @State private var showAlert = false
    @State private var afterEnd = false
    @AppStorage("day") var day = 1
    @StateObject var energyManager = EnergyManager()
    @AppStorage("survived") var survived = false
    

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
                                            Spacer()
                                            Image("metal")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 26, height: 40)
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
                                                .scaledToFit()
                                                .frame(width: 24, height: 40)
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
                                                .scaledToFit()
                                                .frame(width: 28, height: 100)
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
                                                .scaledToFit()
                                                .frame(width: 20, height: 40)
                                            Text("\(itemManager.items[5].amount)")
                                                .font(.system(size: 10))
                                            
                                        }/*.padding(.trailing, 92)*/
                                    }
                                }
                            }
                            HStack{
                                ZStack{
                                    Circle()
                                        .fill(Color(white: 0.4))
                                        .frame(width: 60)
                                        
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
                    }
                    
                    //Squares
                    BuildingGridView()
                        .environmentObject(buildingManager)
                    //end of squares
                    
                    
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
                                    energyManager.energies[0].amount += 30
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

                      
                        
                    }
                }
                .background() {
                    Image("moon surface img")
                }
                .alert(isPresented: $survived, content: {
                    Alert(title: Text("Congratulations"),
                          message: Text("You survived"),
                          dismissButton: .default(Text("Ok"))
                    )
                })
                    
                //First VSTACK
            }
            .navigationBarBackButtonHidden()
        }
        .environmentObject(gameState)   // Inject gameState instance here to Pass GameState to child views
        .environmentObject(player) // Inject player instance here to Pass GameState to child views
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

