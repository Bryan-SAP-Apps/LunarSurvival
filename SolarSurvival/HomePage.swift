//
//  GameMain.swift
//  SolarSurvival
//
//  Created by Ted Tan on 14/11/24.
//

import SwiftUI

struct GameMain: View {
    
    @State var energyBar:Double = 0.9
    var items = [
        Item(name: "metal", amount: 0),
        Item(name: "regolith", amount: 0),
        Item(name: "glass", amount: 0),
        Item(name: "rubber", amount: 0),
        Item(name: "plastic", amount: 0),
        Item(name: "electronics", amount: 0)
    ]
    
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
                                            Text("\(items[2].amount)")
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
                                                .frame(width: 30, height: 40)
                                            Text("\(items[0].amount)")
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
                                                .frame(width: 30, height: 40)
                                            Text("\(items[4].amount)")
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
                                                .frame(width: 30, height: 40)
                                            Text("\(items[3].amount)")
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
                                                .frame(width: 30, height: 40)
                                            Text("\(items[2].amount)")
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
                                            Text("\(items[5].amount)")
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
                                .fill(Color(white: 0.7))
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
                                        .frame(width: energyBar*200, height: 34)
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
                                NavigationLink(destination: PlatformView()) {
                                    Text("Scavenge")
                                        .frame(width:150, height: 30)
                                        .font(.title)
                                        .bold()
                                        .padding()
                                        .background(Color.green)
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
                                
                            }
                        }
                        NavigationLink(destination: CongratView()) {
                            Text("End Day")
                                .padding(.trailing, 30)
                                .padding(.leading, 30)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .font(.title)
                                .bold()
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 19))
                            
                        }
                        
                    }
                }
                .background() {
                    Image("moon surface img")
                }
                //First VSTACK
            }
        }
    }
}

#Preview {
    GameMain()
}
