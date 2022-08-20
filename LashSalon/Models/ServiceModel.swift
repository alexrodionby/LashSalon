//
//  ServiceModel.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

import Foundation

struct ServiceModel: Identifiable {
    
    var id: String
    var serviceName: String
    var serviceTime: Int
    var servicePrice: Int
}
