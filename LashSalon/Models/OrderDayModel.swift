//
//  OrderModel.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 16.08.22.
//

import Foundation

struct OrderDayModel: Identifiable {
    
    var id: String
    var day: String
    var time1: Bool
    var time2: Bool
    var time3: Bool
    var time4: Bool
}
