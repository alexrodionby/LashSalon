//
//  OrderViewModel.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 18.08.22.
//

import Foundation
import Firebase

class OrderViewModel: ObservableObject {
    
    @Published var orderDay: [OrderDayModel] = []
    
    // Берем все дни в месяце, а возвращаем только один заданный на входе
    func getAllDaysInMonthReturnOne(month: String, day: String) async throws -> OrderDayModel {
        let db = Firestore.firestore()
        var newOrderDay: OrderDayModel?
        do {
            let result = try await db.collection(month).getDocuments()
                self.orderDay = result.documents.map { doc in
                    OrderDayModel(id: doc.documentID,
                                  day: doc["day"] as? String ?? "",
                                  time1: doc["time1"] as? Bool ?? false,
                                  time2: doc["time2"] as? Bool ?? false,
                                  time3: doc["time3"] as? Bool ?? false,
                                  time4: doc["time4"] as? Bool ?? false)
                }
            self.orderDay.map { order in
                if order.day == day {
                    newOrderDay = order
                }
            }
            print("newOrderDay =", newOrderDay ?? "nil")
            return newOrderDay ?? OrderDayModel.init(id: "", day: "0", time1: false, time2: false, time3: false, time4: false)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    // Создаем документ в БД с заказом услуги
    func createDayOfSeviceOrder(month: String, day: String, serviceName: String, time: String, userName: String, userPhone: String, token: String) {
        let db = Firestore.firestore()
        db.collection("Orders").addDocument(data: ["day": day, "month": month, "serviceName": serviceName, "time": time, "userName": userName, "userPhone": userPhone, "token": token]) { error in
            if error == nil {
                print("Удалось создать запись в БД")
            } else {
                print(error?.localizedDescription ?? "Some error")
            }
        }
    }
    
    // Делаем недоступно переданное время в дне
    func modifyDayOfSeviceOrder(id: String, month: String, time: String) {
        let db = Firestore.firestore()
        db.collection(month).document(id).setData([time: false], merge: true) { error in
            if error == nil {
                print("Удалось замень доступность времени в этом дне")
            } else {
                print(error?.localizedDescription ?? "Some error")
            }
        }
    }
    
    // Берем все заказы, выбираем заданные по токену, и возвращаем их
    func getAllOrdersByToken(token: String) async throws -> [OrderModel] {
        let db = Firestore.firestore()
        var newAllOrders: [OrderModel] = []
        do {
            let result = try await db.collection("Orders").getDocuments()
                let allOrders = result.documents.map { doc in
                    OrderModel(id: doc.documentID,
                               day: doc["day"] as? String ?? "",
                               month: doc["month"] as? String ?? "",
                               serviceName: doc["serviceName"] as? String ?? "",
                               time: doc["time"] as? String ?? "",
                               token: doc["token"] as? String ?? "",
                               userName: doc["userName"] as? String ?? "",
                               userPhone: doc["userPhone"] as? String ?? "")
                }
            allOrders.map { order in
                if order.token == token {
                    newAllOrders.append(order)
                }
            }
            return newAllOrders
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
}

