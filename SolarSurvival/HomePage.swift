//
//  GameMain.swift
//  SolarSurvival
//
//  Created by Ted Tan on 14/11/24.
//

import SwiftUI

struct GameMain: View {
    var body: some View {
        NavigationStack{
            ZStack{
                
                VStack{
                    
                    
                    
                    HStack{
                        
                        ZStack{
                            ZStack{
                                
                                
                                
                                
                                Rectangle()
                                    .fill(Color(white: 0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 19))
                                    .frame(width: 470, height: 50)
                                    .padding(.trailing, 30)
                                HStack{
                                    Rectangle()
                                        .fill(Color(white: 0.5))
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .frame(width: 60, height: 40)
                                    
                                    
                                        Rectangle()
                                            .fill(Color(white: 0.5))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 60, height: 40)
                                    
                                    
                                        Rectangle()
                                            .fill(Color(white: 0.5))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 60, height: 40)
                                    
                                    
                                        Rectangle()
                                            .fill(Color(white: 0.5))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 60, height: 40)
                                    
                                    
                                        Rectangle()
                                            .fill(Color(white: 0.5))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 60, height: 40)
                                    
                                    
                                        Rectangle()
                                            .fill(Color(white: 0.5))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(width: 60, height: 40)
                                }
                                .padding(.leading, 20)
                            }
                            ZStack{
                                Circle()
                                    .fill(Color(white: 0.4))
                                    .frame(width: 60)
                                    .padding(.trailing)
                                    .offset(x: -220 ,y: 0)
                            }
                            
                        }
                        Spacer()
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(white: 0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 19))
                                .frame(width: 290, height: 50)
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
                        }
                        NavigationLink(destination: PlatformView()) {
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
