//
//  StorageViewModel.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 16.08.22.
//

// Вьюмодель, для получения файлов из firebase
import Foundation
import FirebaseStorage

class StorageViewModel: ObservableObject {
    
    // Асинхронный запрс на получение всех путей к файлам в папке salon в базе данных
    func getSalonAllPhotoPathAsync() async throws -> [String] {
        let storage = Storage.storage()
        let storageReference = storage.reference().child("/salon")
        do {
            let result = try await storageReference.listAll()
            let tempPath = result.items.map { $0.fullPath }
            return tempPath
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    // Асинхронный запрос на получение всех URL на файлы, которые лежат в папке salon
    func getSalonAllPhotoURLAsync() async throws -> [URL] {
        let storage = Storage.storage()
        let storageReference = storage.reference().child("/salon")
        var urls: [URL] = []
        do {
            let result = try await storageReference.listAll()
            let tempPath = result.items.map { $0.fullPath }
            let newStorage = tempPath.map { storage.reference().child("\($0)") }
            for item in newStorage {
                let newURL = try await item.downloadURL()
                urls.append(newURL)
            }
            return urls
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
}
