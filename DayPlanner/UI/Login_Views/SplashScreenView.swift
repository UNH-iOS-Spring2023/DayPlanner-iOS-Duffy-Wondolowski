//
//  SplashScreenView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/15/23.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            LandingView()
        } else {
            VStack{
                CustomColor.background
                    .ignoresSafeArea(.all)
                    .overlay {
                        VStack{
                            Image("Logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350)
                        }.scaleEffect(size)
                            .opacity(opacity)
                            .onAppear{
                                withAnimation(.easeIn(duration: 1.2)){
                                    self.size = 0.9
                                    self.opacity = 1.00
                                }
                            }
                    }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
                
            }
            
            
            
        }
        
        
        
        
        
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
