//
//  ContentView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 14.08.22.
//

import SwiftUI

struct HomeView: View {
    
    // Передаем объект, чтобы можно было использовать переход по табам
    @EnvironmentObject var router: TabRouter
    
    // Передаем нашу вьюмодель
    @ObservedObject var serviceCategoryModel = ServiceCategoryViewModel()
    
    // Настраиваем внешний вид LazyVGrid
    @State var gridLayout: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    // Делаем сетевой запрос на инициализации экрана + внешний вид навбара
    init() {
        UINavigationBar.appearance().barTintColor = UIColor(named: "brown1")
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(named: "brown6")!]
        serviceCategoryModel.getServiceCategory()
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                
                Image("logoblack")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
                
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 0) {
                    
                    ForEach(serviceCategoryModel.serviceCategoryData) { index in
                        
                        NavigationLink(destination: ServiceDetailView(categorey: index)) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color("brown4"))
                                    .shadow(color: .gray, radius: 10, x: 5, y: 5)
                                    .padding()
                                Text("\(index.serviceCategoryName)")
                                    .lineLimit(5)
                                    .frame(width: 150, height: 150, alignment: .center)
                                    .font(.body)
                                    .foregroundColor(Color.white)
                                    .padding()
                            }
                        }
                    }
                }
            }
            
            .navigationTitle("Главная")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("brown1"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TabRouter()) // Добавляем так, чтобы не падоло на превью
    }
}
