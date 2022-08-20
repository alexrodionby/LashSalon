//
//  ServiceCategoryViewModel.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 15.08.22.
//

import Foundation
import Firebase

class ServiceCategoryViewModel: ObservableObject {
    
    @Published var serviceCategoryData: [ServiceCategoryModel] = []
    @Published var serviceData: [ServiceModel] = []
    @Published var specialistData: [SpecialistModel] = []
    
    // Возвращаем все категории услуг
    func getServiceCategory() {
        let db = Firestore.firestore()
        db.collection("ServiceCategory").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.serviceCategoryData = snapshot.documents.map { doc in
                            return ServiceCategoryModel(id: doc.documentID,
                                                        serviceCategoryName: doc["serviceCategoryName"] as? String ?? "",
                                                        serviceSubCategoryName: doc["serviceSubCategoryName"] as? String ?? "")
                        }
                    }
                }
            } else {
                print(error?.localizedDescription ?? "Some error")
            }
        }
    }
    
    // Возвращаем список всех услуг в категории (из одного раздела усуг)
    func getSubService(subServiceName: String, subID: String) {
        let db = Firestore.firestore()
        db.collection("ServiceCategory").document(subID).collection(subServiceName).getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.serviceData = snapshot.documents.map { doc in
                            return ServiceModel(id: doc.documentID,
                                                serviceName: doc["serviceName"] as? String ?? "",
                                                serviceTime: doc["serviceTime"] as? Int ?? 0,
                                                servicePrice: doc["servicePrice"] as? Int ?? 0)
                        }
                    }
                }
            } else {
                print(error?.localizedDescription ?? "Some error")
            }
        }
    }
    
    // Возвращаем список всех специалистов из базы данных
    func getAllSpecialist() {
        let db = Firestore.firestore()
        db.collection("Specialists").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.specialistData = snapshot.documents.map { doc in
                            return SpecialistModel(id: doc.documentID,
                                                   specialistName: doc["specialistName"] as? String ?? "",
                                                   specialistPhotoURL: doc["specialistPhotoURL"] as? String ?? "",
                                                   specialistDescription: doc["specialistDescription"] as? String ?? "")
                        }
                    }
                }
            } else {
                print(error?.localizedDescription ?? "Some error")
            }
        }
    }
    
}
