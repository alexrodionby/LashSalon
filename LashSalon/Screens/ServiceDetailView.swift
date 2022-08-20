//
//  ServiceDetailView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

import SwiftUI

struct ServiceDetailView: View {
    
    let categorey: ServiceCategoryModel?
    
    @ObservedObject var serviceCategoryModel = ServiceCategoryViewModel()
    
    @State var gridLayout: [GridItem] = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, alignment: .center) {
                ForEach(serviceCategoryModel.serviceData) { index in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("brown4"))
                            .shadow(color: .gray, radius: 10, x: 5, y: 5)
                            .padding()
                        
                        HStack {
                            VStack {
                                Text("\(index.serviceName)")
                                    .font(.body)
                                    .foregroundColor(Color.white)
                                    .padding()
                            }
                            
                            VStack {
                                Text("\(index.serviceTime) мин")
                                    .foregroundColor(Color.white)
                                    .padding()
                                Text("\(index.servicePrice) руб")
                                    .foregroundColor(Color.white)
                                    .padding()
                            }
                            
                            VStack {
                                Link("Заказать на сайте", destination: URL(string: "https://dikidi.net/684321")!)
                                    .foregroundColor(Color("gold"))
                                    .font(.title2)
                                    .padding()
                                
                                NavigationLink(destination: OrderView(orderCategory: index)) {
                                    Text("Перейти к заказу")
                                        .padding()
                                        .foregroundColor(Color("gold"))
                                        .font(.title2)
                                        .lineLimit(3)
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
