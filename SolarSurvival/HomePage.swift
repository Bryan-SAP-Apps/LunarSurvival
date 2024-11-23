//
//  GameMain.swift
//  SolarSurvival
//
//  Created by Ted Tan on 14/11/24.
//

import SwiftUI

struct HomePage: View {
    @StateObject var itemManager = ItemManager()
    @AppStorage("1")var building1 = ""
    @State private var showAlert = false
    @State private var afterEnd = false
    @AppStorage("day") var day = 0

    var items = [
        Item(name: "metal", amount: 0),
        Item(name: "regolith", amount: 0),
        Item(name: "glass", amount: 0),
        Item(name: "rubber", amount: 0),
        Item(name: "plastic", amount: 0),
        Item(name: "electronics", amount: 0)
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
                                    .frame(width: 490, height: 50)
                                    .padding(.trailing, 30)
                                HStack{
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 60, height: 40)
                                        HStack{
                                            Image("glass")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 40)
                                            Text("\(itemManager.items[2].amount)")
                                                .font(.system(size: 10))
                                        }
                                        .frame(width:50)
                                    }
                                    
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 60, height: 40)
                                        HStack{
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
                                            .frame(width: 60, height: 40)
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
                                            .frame(width: 60, height: 40)
                                        HStack{
                                            Image("rubber")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 28, height: 40)
                                            Text("\(itemManager.items[3].amount)")
                                                .font(.system(size: 10))
                                        }
                                        .frame(width:50)
                                    }
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 60, height: 40)
                                        HStack{
                                            Image("regolith")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 28, height: 40)
                                            Text("\(itemManager.items[1].amount)")
                                                .font(.system(size: 10))
                                        }
                                        .frame(width:50)
                                    }
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(white: 0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 60, height: 40)
                                        HStack{
                                            Image("electronics")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 40)
                                            Text("\(itemManager.items[5].amount)")
                                                .font(.system(size: 10))
                                        }
                                        .frame(width:50)
                                    }
                                }
                                .padding(.leading, 20)
                            }
                            ZStack{
                                Circle()
                                    .fill(Color(white: 0.4))
                                    .frame(width: 60)
                                    .padding(.trailing)
                                    .offset(x: -230 ,y: 0)
                            }
                            
                        }
                        Spacer()
                        
                        ZStack{
                            
                            Rectangle()
                                .fill(Color(white: 0.6))
                                .clipShape(RoundedRectangle(cornerRadius: 19))
                                .frame(width: 250, height: 50)
                            HStack{
                                Spacer()
                                Image(systemName: "bolt.fill")
                                Spacer()
                                ZStack(alignment: .trailing) {
                                    Rectangle()
                                        .fill(Color(.white))
                                        .frame(width: 200, height: 34)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                    Rectangle()
                                        .fill(Color(.yellow))
                                        .frame(width: CGFloat(gameState.energyBar*2), height: 34)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
                                Spacer()
                                
                            }
                        }
                    }
                    //Squares
                    VStack{
                       
                        HStack{
                           
                            ZStack{
                                Rectangle()
                                    .fill(Color(white: 0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 21.6))
                                    .frame(width: 100, height: 100)
                                Image("\(building1)")
                                    .resizable()
                                    .frame(width: 90, height: 90)
                            }
                            ZStack{
                                Rectangle()
                                    .fill(Color(white: 0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 21.6))
                                    .frame(width: 100, height: 100)
                                    
                                
                            }
                        }
                        HStack{
                            ZStack{
                                Rectangle()
                                    .fill(Color(white: 0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 21.6))
                                    .frame(width: 100, height: 100)
                            }
                            ZStack{
                                Rectangle()
                                    .fill(Color(white: 0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 21.6))
                                    .frame(width: 100, height: 100)
                            }
                            
                        }
                    }
                    //end of squares
                    
                    
                    
                    HStack{
                        ZStack{
                            Rectangle()
                                .fill(Color(white: 0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 21.6))
                                .frame(width: 500, height: 70)
                            HStack{
                                NavigationLink(destination: PlatformHolder()) {
                                    Text("Scavenge")
                                        .frame(width:150, height: 30)
                                        .font(.title)
                                        .bold()
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 19))
                                    
                                }
                                NavigationLink(destination: InfrastructureBuildingChoices()) {
                                    Text("Build")
                                        .frame(width:150, height: 30)
                                        .font(.title)
                                        .bold()
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 19))
                                    
                                }
                                Button(action: {
                                    gameState.energyBar -= 20
                                }, label: {
                                    Text("Eat")
                                        .frame(width:150, height: 30)
                                        .font(.title)
                                        .bold()
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 19))
                                })
                                
                            }
                            }
                            
                                
                        NavigationLink(destination: AfterEndDay(), isActive: $afterEnd) {
                            Button(action: {
                                day += 1
                                afterEnd = true
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
//                        Button(action: {
////                            showAlert = true
//                            day = 1
//                            
//                        }, label: {
//                            Text("End Day")
//                                     Text("End Day")                      .frame(width:150,height: 50)
//                                                           .font(.title)
//                                                           .bold()
//                                                           .padding()
//                                                           .background(Color.green)
//                                                           .foregroundColor(.white)
//                                                           .clipShape(RoundedRectangle(cornerRadius: 19))
//                        })
//                        .alert(isPresented:$showAlert){
//                        Alert (
//                        title:Text("Something went wrong"),
//                        message:Text("Not enough resources"),
//                        dismissButton:. default(Text("done"))
//                        )
//                        }
                        
                    }
                }
                .background() {
                    Image("moon surface img")
                }
                    
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
            .environmentObject(Player(startPosition: CGPoint(x: 200, y: 300))) // Test if Player can be injected
    }
}

