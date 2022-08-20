//
//  SettingsView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

import SwiftUI
import FirebaseService

struct SettingsView: View {
    
    @State var showLoginView: Bool = false
    @State var userName = Session.shared.userName
    @State var userPhone = Session.shared.userPhone
    
    @StateObject private var appleService = FirebaseSignInWithAppleService()
    @StateObject private var viewModel = ViewModel()
    @StateObject private var authState = AuthState()
    
    var body: some View {
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
                            .background(Color("brown1"))
                            .accentColor(Color("brown6"))
                        }
                        
                    }
                    Spacer()
                }
            }
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
         print("Наш токен =", Session.shared.token)
          print("Наше имя =", Session.shared.userName)
         print("Наш телефон =", Session.shared.userPhone)
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
