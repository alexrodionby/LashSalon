//
//  CoordinatorView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

import SwiftUI

// Перечисляем наши экраны, чтобы потом добавить теги на них
enum Screens {
    case home
    case records
    case chat
    case settings
    case about
}

// Ксласс-синглтон роутер перехода между табэкранами
final class TabRouter: ObservableObject {
    
    @Published var screen: Screens = .home
    func change(to screen: Screens) {
        self.screen = screen
    }
}

struct CoordinatorView: View {
    
    // Нужно передавать стэйтобжект таброутера
    @StateObject var router = TabRouter()
    
    // Меняем внешний вид таббара
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "brown1")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "brown3")
    }
    
    var body: some View {
        TabView(selection: $router.screen) {
            HomeView()
                .tag(Screens.home) // Ставим тэг экрана
                .environmentObject(router) // Передаем объект
                .tabItem {
                    Label("Главная", systemImage: "house")
                }
            RecordsView()
                .tag(Screens.records)
                .environmentObject(router)
                .tabItem {
                    Label("Мои записи", systemImage: "calendar")
                }
            AboutView()
                .tag(Screens.about)
                .environmentObject(router)
                .tabItem {
                    Label("О салоне", systemImage: "info.circle")
                }
            // Временно не используем этот экран
//            ChatView()
//                .tag(Screens.chat)
//                .environmentObject(router)
//                // Используем бэйдж позже
//                // .badge(5)
//                .tabItem {
//                    Label("Чат", systemImage: "text.bubble")
//                }
            SettingsView()
                .tag(Screens.settings)
                .environmentObject(router)
                .tabItem {
                    Label("Ещё", systemImage: "line.3.horizontal")
                }
        }
        .accentColor(Color("brown6")) // Цвет кнопок таббара
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
    }
}
