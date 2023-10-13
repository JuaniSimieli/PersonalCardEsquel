//
//  MultiImagePicker.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 13/10/2023.
//

import Foundation
import SwiftUI
import PhotosUI

struct MultiImagePicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Environment(\.presentationMode) var presentationMode
    var minImages: Int = 0
    var maxImages: Int = 4

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        
        // Establecer el límite de selección basado en el valor pasado o en el default (4)
        config.selectionLimit = images.isEmpty ? max(minImages, 4) : (maxImages > 0 ? maxImages : 4)
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: MultiImagePicker

        init(_ parent: MultiImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if parent.images.isEmpty && results.count < parent.minImages {
                // Esto asegura que si no hay imágenes, el usuario debe seleccionar al menos 'minImages'
                parent.presentationMode.wrappedValue.dismiss()
                return
            }
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.images.append(image)
                            }
                        }
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
