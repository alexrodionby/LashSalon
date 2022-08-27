//
//  ServiceCategoryModel.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

// Модель категории услуги
import Foundation

struct ServiceCategoryModel: Identifiable {
    
    var id: String
    var serviceCategoryName: String
    var serviceSubCategoryName: String
}
