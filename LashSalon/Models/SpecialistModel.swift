//
//  SpecialistModel.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

// Модель специалиста салона
import Foundation

struct SpecialistModel: Identifiable {
    
    var id: String
    var specialistName: String
    var specialistPhotoURL: String
    var specialistDescription: String
}
