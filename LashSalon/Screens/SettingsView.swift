//
//  SettingsView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

// Экран настроек программы
import SwiftUI
import FirebaseService

struct SettingsView: View {
    
    // Флаг, показывать ли экран авторизации
    @State var showLoginView: Bool = false
    
    // Переменные для сохранения данных пользователя
    @State var userName = Session.shared.userName
    @State var userPhone = Session.shared.userPhone
    
    // Добавляем вьмодели
    @StateObject private var appleService = FirebaseSignInWithAppleService()
    @StateObject private var viewModel = ViewModel()
    @StateObject private var authState = AuthState()
    
    // Инициализатор
    init() {
        UINavigationBar.appearance().barTintColor = UIColor(named: "brown1")
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(named: "brown6")!]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("brown1").ignoresSafeArea()
                
                VStack {
                    
                    Image("logoblack")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                    
                    switch authState.value {
                    case .undefined:
                        ProgressView()
                    case .authenticated:
                        HStack {
                            VStack {
                                Image("girl")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text(Session.shared.userName)
                            }
                            
                            Button {
                                Task {
                                    do {
                                        try await viewModel.logout()
                                    } catch {
                                        print("Ошибка выхода", error.localizedDescription)
                                    }
                                }
                            } label: {
                                Label {
                                    Text("Выход из учетной записи")
                                } icon: {
                                    Image(systemName: "person.fill.badge.minus")
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            
                        }
                        Spacer()
                    case .notAuthenticated:
                        HStack {
                            Image("girl")
                                .resizable()
                                .frame(width: 100, height: 100)
                            Button {
                                showLoginView = true
                            } label: {
                                Label {
                                    Text("Войти через Apple")
                                } icon: {
                                    Image(systemName: "applelogo")
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            
                            // Тут показываем sheet по флагу, который и будет нашим экраном авторизации
                            .sheet(isPresented: $showLoginView) {
                                VStack {
                                    Image("logoblack")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                    HStack {
                                        Text("Ваше имя:")
                                            .padding()
                                        TextField(text: $userName) {
                                            Text("Имя")
                                        }
                                        .border(.black, width: 1)
                                        .padding()
                                    }
                                    HStack {
                                        Text("Ваш номер телефона:")
                                            .padding()
                                        TextField(text: $userPhone) {
                                            Text("+375291234567")
                                        }
                                        .border(.black, width: 1)
                                        .padding()
                                    }
                                    
                                    Button {
                                        authenticate()
                                        showLoginView = false
                                    } label: {
                                        Label {
                                            Text("Войти через Apple")
                                        } icon: {
                                            Image(systemName: "applelogo")
                                        }
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .padding()
                                    
                                    Spacer()
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("brown1"))
        }
    }
    
    func authenticate() {
        // Входим используя полную авторизацию
        appleService.signIn { result in
            handleAppleServiceSucces(result)
        } onFailed: { error in
            handleAppleServiceError(error)
        }
    }
    
    func handleAppleServiceSucces(_ result: FirebaseSignInWithAppleResult) {
        
        // Сохраняем результаты того что получили в ответ на аторизацию
        Session.shared.token = result.uid
        Session.shared.userName = userName
        Session.shared.userPhone = userPhone
        //print("Наш токен =", Session.shared.token)
        //print("Наше имя =", Session.shared.userName)
        //print("Наш телефон =", Session.shared.userPhone)
    }
    
    func handleAppleServiceError(_ error: Error) {
        // тут можно алерт поставить на ошибку
        print("Ошибка авторизации Apple", error.localizedDescription)
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
