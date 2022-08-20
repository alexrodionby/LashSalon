//
//  LogoView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

import SwiftUI

struct LogoView: View {
    
    @State private var logoIsActive = false
    @State private var logoSize = 0.1
    @State private var logoOpacity = 0.1
    
    var body: some View {
        
        if logoIsActive {
            CoordinatorView()
        } else {
            ZStack {
                Image("backimage")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Image("logowhite")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                .scaleEffect(logoSize)
                .opacity(logoOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)) {
                        self.logoSize = 1.0
                        self.logoOpacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.logoIsActive = true
                    }
                }
            }
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
