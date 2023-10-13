//
//  UserImages.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 13/10/2023.
//

import Foundation
import UIKit

class UserImages: ObservableObject {
    @Published var customImages: [UIImage] = [] {
        didSet {
            if customImages.isEmpty {
                // Si el array está vacío, elimina las imágenes del almacenamiento
                removeImagesFromDisk()
            } else {
                // Si no está vacío, guarda las imágenes
                saveImagesToDisk()
            }
        }
    }

    init() {
        loadImagesFromDisk()
    }

    private func saveImagesToDisk() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Borrar imágenes antiguas primero
        let oldNumberOfImages = UserDefaults.standard.integer(forKey: "numberOfCustomImages")
        
        if oldNumberOfImages > 0 {
            for i in 1...oldNumberOfImages {
                let filePath = documentDirectory.appendingPathComponent("customImage\(i).jpg")
                do {
                    try fileManager.removeItem(at: filePath)
                } catch {
                    print("Error eliminando imagen antigua: \(error)")
                }
            }
        }
        
        // Guardar imágenes actuales
        for (index, image) in customImages.enumerated() {
            let filePath = documentDirectory.appendingPathComponent("customImage\(index + 1).jpg")
            do {
                if let data = image.jpegData(compressionQuality: 1.0) {
                    try data.write(to: filePath)
                }
            } catch {
                print("Error guardando imagen: \(error)")
            }
        }
        
        UserDefaults.standard.set(customImages.count, forKey: "numberOfCustomImages")
    }

    private func loadImagesFromDisk() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let numberOfImages = UserDefaults.standard.integer(forKey: "numberOfCustomImages")

        var loadedImages: [UIImage] = []  // Array temporal para cargar las imágenes

        if numberOfImages > 0 {
            for i in 1...numberOfImages {
                let filePath = documentDirectory.appendingPathComponent("customImage\(i).jpg")

                // Verifica primero si el archivo realmente existe
                if fileManager.fileExists(atPath: filePath.path), let image = UIImage(contentsOfFile: filePath.path) {
                    loadedImages.append(image)  // Agrega las imágenes al array temporal
                }
            }
        }

        customImages = loadedImages  // Asigna el array temporal a customImages una vez que todas las imágenes han sido cargadas
    }


    private func removeImagesFromDisk() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let oldNumberOfImages = UserDefaults.standard.integer(forKey: "numberOfCustomImages")
        
        if oldNumberOfImages > 0 {
            for i in 1...oldNumberOfImages {
                let filePath = documentDirectory.appendingPathComponent("customImage\(i).jpg")
                do {
                    try fileManager.removeItem(at: filePath)
                } catch {
                    print("Error eliminando imagen: \(error)")
                }
            }
        }
        
        UserDefaults.standard.removeObject(forKey: "numberOfCustomImages")
    }
}


