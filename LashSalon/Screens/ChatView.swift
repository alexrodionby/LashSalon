//
//  ChatView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

// Экран чата с администратором (находится в стадии разработки)
import SwiftUI

struct ChatView: View {
    
    // Передаем объект, чтобы можно было использовать переход
    @EnvironmentObject var router: TabRouter
    
    var body: some View {
        ZStack {
            Color("brown1").ignoresSafeArea()
            VStack {
                Text("Экран чата находится в разработке")
                Button {
                    // Этим вызываем переход на другой табэкран
                    router.change(to: .home)
                } label: {
                    Text("На главный экран")
                }
                .padding()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(TabRouter()) // Добавляем так, чтобы не падоло на превью
    }
}
