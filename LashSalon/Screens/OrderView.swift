//
//  OrderView.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 16.08.22.
//

import SwiftUI

struct OrderView: View {
    

    
    @ObservedObject var orderViewModel = OrderViewModel()
    
    var orderCategory: ServiceModel?
    
    @State private var timeOrder = ""
    @State private var timeId = ""
    @State var orderDayToShow: OrderDayModel?
    
    @State var selectDate: Date = Date()
    
    @State private var showAlert = false
    
    var dateFormatter: DateFormatter {
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "ru_RU")
        formater.dateStyle = .medium
        return formater
    }
    
    var dateFormatterDay: DateFormatter {
        let formater = DateFormatter()
        formater.dateFormat = "d"
        formater.locale = Locale(identifier: "en_us")
        return formater
    }
    
    var dateFormatterMonth: DateFormatter {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM"
        formater.locale = Locale(identifier: "en_us")
        return formater
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            Text("Выберите дату")
                .font(.title2)
                .fontWeight(.bold)

            DatePicker("Выберите день", selection: $selectDate, displayedComponents: [.date])
                .labelsHidden()
                .preferredColorScheme(.light)
                .datePickerStyle(.graphical)
                .padding(.horizontal)
                .onChange(of: selectDate) { newValue in
                    print("newValue =", newValue)
                    print(dateFormatterMonth.string(from: newValue))
                    print(dateFormatterDay.string(from: newValue))
                    Task {
                        orderDayToShow = try await orderViewModel.getAllDaysInMonthReturnOne(month: dateFormatterMonth.string(from: newValue), day: dateFormatterDay.string(from: newValue))
                    }
                }
            


            VStack {
                
                Text("Выберите доступное время")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom)
            }
            
            HStack {
                VStack {
                    Text("10:00")
                    if orderDayToShow?.time1 == true {
                        Image(systemName: "checkmark.square.fill").foregroundColor(.green)
                    } else {
                        Image(systemName: "xmark.square.fill").foregroundColor(.red)
                    }

                    Button {
                        showAlert = true
                        timeOrder = "10:00"
                        timeId = "time1"
                    } label: {
                        Text("Заказать")
                            .foregroundColor(Color("brown6"))
                            .padding(5)
                    }
                }
                
                VStack {
                    Text("12:00")
                    if orderDayToShow?.time2 == true {
                        Image(systemName: "checkmark.square.fill").foregroundColor(.green)
                    } else {
                        Image(systemName: "xmark.square.fill").foregroundColor(.red)
                    }
                    
                    Button {
                        showAlert = true
                        timeOrder = "12:00"
                        timeId = "time2"
                    } label: {
                        Text("Заказать")
                            .foregroundColor(Color("brown6"))
                            .padding(5)
                    }
                }
                
                VStack {
                    Text("14:00")
                    if orderDayToShow?.time3 == true {
                        Image(systemName: "checkmark.square.fill").foregroundColor(.green)
                    } else {
                        Image(systemName: "xmark.square.fill").foregroundColor(.red)
                    }
                    
                    Button {
                        showAlert = true
                        timeOrder = "14:00"
                        timeId = "time3"
                    } label: {
                        Text("Заказать")
                            .foregroundColor(Color("brown6"))
                            .padding(5)
                    }
                }
                
                VStack {
                    Text("16:00")
                    if orderDayToShow?.time4 == true {
                        Image(systemName: "checkmark.square.fill").foregroundColor(.green)
                    } else {
                        Image(systemName: "xmark.square.fill").foregroundColor(.red)
                    }
                    
                    Button {
                        showAlert = true
                        timeOrder = "16:00"
                        timeId = "time4"
                    } label: {
                        Text("Заказать")
                            .foregroundColor(Color("brown6"))
                            .padding(5)
                    }
                }
                
            }
            .padding(.bottom)
            .alert("Подтвердите заказ", isPresented: $showAlert) {
                
                Button(role: .cancel) {
                    print("Нажали в алерте отмену")
                } label: {
                    Text("Отмена")
                }
                
                Button {
                    // запросы тут ставим
                    orderViewModel.createDayOfSeviceOrder(month: dateFormatterMonth.string(from: selectDate), day: dateFormatterDay.string(from: selectDate), serviceName: orderCategory?.serviceName ?? "Ошибка по nil", time: timeOrder, userName: Session.shared.userName, userPhone: Session.shared.userPhone, token: Session.shared.token)
                    
                    orderViewModel.modifyDayOfSeviceOrder(id: orderDayToShow?.id ?? "", month: dateFormatterMonth.string(from: selectDate), time: timeId)
                    
                    Task {
                        orderDayToShow = try await orderViewModel.getAllDaysInMonthReturnOne(month: dateFormatterMonth.string(from: selectDate), day: dateFormatterDay.string(from: selectDate))
                    }
                } label: {
                    Text("Заказать")
                }

            } message: {
                VStack {
                    Text("Услуга: \(orderCategory?.serviceName ?? "")" +
                         "\nДата: \(dateFormatter.string(from: selectDate))" +
                         "\nВремя: \(timeOrder)")
                }
            }
            
            VStack {
                
                HStack {
                    Text("Услуга:")
                        .fontWeight(.bold)
                    Text(orderCategory?.serviceName ?? "")
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Время:")
                        .fontWeight(.bold)
                    Text("\(orderCategory?.serviceTime ?? 0) минут")
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Стоимость:")
                        .fontWeight(.bold)
                    Text("\(orderCategory?.servicePrice ?? 0) рублей")
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Дата:")
                        .fontWeight(.bold)
                    Text(dateFormatter.string(from: selectDate))
                    Spacer()
                }
                .padding(.horizontal)
            }
            
        }
        .background(Color("brown1"))
        .foregroundColor(Color("brown6"))
    }
}

// Эта константа только для превью
let previewOrderCategoryData: ServiceModel = .init(id: "LCqypPcZpopUgJgm8RDS", serviceName: "Ламинирование ресниц", serviceTime: 90, servicePrice: 40)

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(orderCategory: previewOrderCategoryData)
    }
}
