//
//  RecordsView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

import SwiftUI

struct RecordsView: View {
    
    // Передаем объект, чтобы можно было использовать переход по табам
    @EnvironmentObject var router: TabRouter
    
    // Передаем нашу вьюмодель
    @ObservedObject var orderViewModel = OrderViewModel()
    
    // Настраиваем внешний вид LazyVGrid
    @State var gridLayout: [GridItem] = [GridItem(.flexible())]
    
    @State var allUserRecords: [OrderModel] = []
    
    // Делаем сетевой запрос на инициализации экрана + внешний вид навбара
    init() {
        UINavigationBar.appearance().barTintColor = UIColor(named: "brown1")
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(named: "brown6")!]
        // запрос
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Image("logoblack")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
                
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 0) {
                    
                    ForEach(allUserRecords) { index in
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("brown4"))
                                .shadow(color: .gray, radius: 10, x: 5, y: 5)
                                .padding()
                            VStack {
                                HStack{
                                    Text("Имя:")
                                    Text((index.userName) == "" ? "Без имени" : "\(index.userName)")
                                }
                                HStack {
                                    Text("Номер телефона:")
                                    Text((index.userPhone) == "" ? "Без номера" : "\(index.userPhone)")
                                }
                                HStack {
                                    Text("Услуга:")
                                    Text("\(index.serviceName)")
                                }
                                HStack {
                                    Text("Дата и время:")
                                    Text("\(index.day)")
                                    Text("\(index.month)")
                                    Text("\(index.time)")
                                }
                            }
                            .font(.body)
                            .foregroundColor(Color.white)
                            .padding(20)
                        }
                    }
                }
            }
            .navigationTitle("Мои записи")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("brown1"))
        }
        .onAppear {
            Task {
                // Для теста токен пустой или vCEmcPeSfKdf1rrduJLcri1biV22
                allUserRecords = try await orderViewModel.getAllOrdersByToken(token: "")
            }
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView()
    }
}
