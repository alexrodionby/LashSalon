//
//  OrderModel.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 20.08.22.
//

// Сама модель заказа услуги
import Foundation

struct OrderModel: Identifiable {
    
    var id: String
    var day: String
    var month: String
    var serviceName: String
    var time: String
    var token: String
    var userName: String
    var userPhone: String
    var homeDayId: String
    var homeTimeId: String
}
