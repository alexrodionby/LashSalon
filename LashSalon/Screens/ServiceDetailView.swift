//
//  ServiceDetailView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

// Экран детализации услуги (после выбора категории услуги)
import SwiftUI

struct ServiceDetailView: View {
    
    // Определяем константу для модели
    let categorey: ServiceCategoryModel?
    
    // Передаем нашу вьюмодель
    @ObservedObject var serviceCategoryModel = ServiceCategoryViewModel()
    
    // Настраиваем внешний вид LazyVGrid
    @State var gridLayout: [GridItem] = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridLayout, alignment: .center) {
                ForEach(serviceCategoryModel.serviceData) { index in
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("brown4"))
                            .shadow(color: .gray, radius: 10, x: 5, y: 5)
                            .padding()
                        
                        VStack {
                            
                            Text("\(index.serviceName)")
                                .font(.body)
                                .foregroundColor(Color.white)
                                .padding()
                            
                            HStack {
                                Text("Время: \(index.serviceTime) мин")
                                    .foregroundColor(Color.white)
                                    .padding(.horizontal)
                                
                                Text("Стоимость: \(index.servicePrice) руб")
                                    .foregroundColor(Color.white)
                                    .padding(.horizontal)
                            }
                            
                            HStack {
                                Link("Заказ на сайте", destination: URL(string: "https://dikidi.net/684321")!)
                                    .foregroundColor(Color("gold"))
                                    .font(.title2)
                                    .padding()
                                
                                NavigationLink(destination: OrderView(orderCategory: index)) {
                                    Text("Перейти к заказу")
                                        .foregroundColor(Color("gold"))
                                        .font(.title2)
                                        .padding()
                                }
                            }
                        }
                        .padding()
                        .navigationTitle(categorey?.serviceCategoryName ?? "")
                    }
                }
            }
        }
        .background(Color("brown1"))
        .onAppear {
            serviceCategoryModel.getSubService(subServiceName: categorey?.serviceSubCategoryName ?? "", subID: categorey?.id ?? "")
        }
    }
}

// Эта константа только для превью
let previewCategoryData: ServiceCategoryModel = .init(id: "zGsFq03nBr97RsxFWn9t", serviceCategoryName: "Наращивание ресниц", serviceSubCategoryName: "eyelashExtensions")

struct ServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailView(categorey: previewCategoryData)
            .environmentObject(TabRouter())
    }
}
