//
//  MultiImagePickerView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 13/10/2023.
//

import SwiftUI

struct MultiImagePickerView: View {
    @State private var selectedImages: [UIImage]
    @State private var isImagePickerPresented: Bool = false
    @State private var isEditing: Bool = false
    @State private var imagesToBeDeleted: Set<Int> = []
    @State private var showAlert = false
    @State private var showMinimumImageAlert: Bool = false
    @EnvironmentObject var userImages: UserImages
    
    init(currentImages: [UIImage]) {
        _selectedImages = State(initialValue: currentImages)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button("Agregar") {
                        isImagePickerPresented.toggle()
                    }
                    .disabled(isEditing)
                    .opacity(isEditing ? 0.5 : 1.0)
                    Spacer()
                    Spacer()
                    Button(action: toggleEditMode) {
                        if isEditing {
                            if imagesToBeDeleted.isEmpty {
                                Text("Aceptar")
                                    .foregroundColor(.blue)
                            } else {
                                Text("Eliminar")
                                    .foregroundColor(.red)
                            }
                        } else {
                            Text("Editar")
                                .foregroundColor(selectedImages.isEmpty ? .gray : .blue)
                        }
                    }
                    .disabled(selectedImages.isEmpty)
                    Spacer()
                }
                .padding()
                
//                Text("Podes agreagar de a 3 imagenes a la vez")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .padding(.horizontal)
                
                ScrollView {
                    ImagesGridView(images: $selectedImages, isEditing: $isEditing, selectedImages: $imagesToBeDeleted)
                        .sheet(isPresented: $isImagePickerPresented, onDismiss: checkMinimumImagesRequired) {
                            MultiImagePicker(images: $selectedImages)
                        }
                        .onAppear {
                            if selectedImages.isEmpty {
                                isImagePickerPresented = true
                            }
                        }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Debes dejar al menos 3 fotos"), dismissButton: .default(Text("Entendido")))
            }
            .alert(isPresented: $showMinimumImageAlert) {
                Alert(title: Text("Error"),
                      message: Text("Debes seleccionar al menos 3 imágenes"),
                      dismissButton: .default(Text("Entendido")) {
                          // Abre nuevamente el picker
                          isImagePickerPresented = true
                      })
            }
        }
    }
    
    func checkMinimumImagesRequired() {
        if selectedImages.count < 3 {
            showMinimumImageAlert = true
        } else {
            userImages.customImages = selectedImages
        }
    }



    
    func toggleEditMode() {
        if isEditing && !imagesToBeDeleted.isEmpty {
            if selectedImages.count - imagesToBeDeleted.count >= 3 {
                // Obtén las imágenes restantes después de la eliminación
                let remainingImages = selectedImages.indices
                    .filter { !imagesToBeDeleted.contains($0) }
                    .map { selectedImages[$0] }
                
                // Actualiza el array local de imágenes seleccionadas
                selectedImages = remainingImages
                
                // **IMPORTANTE**: Actualiza también el array global de imágenes personalizadas
                userImages.customImages = remainingImages
                
                // Limpia el set de imágenes a ser eliminadas
                imagesToBeDeleted.removeAll()
            } else {
                showAlert = true
            }
        }
        isEditing.toggle()
    }

}

struct ImagesGridView: View {
    @Binding var images: [UIImage]
    @Binding var isEditing: Bool
    @Binding var selectedImages: Set<Int>
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
        LazyVGrid(columns: columns, spacing: 3) {
            ForEach(images.indices, id: \.self) { index in
                ZStack {
                    Image(uiImage: images[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                    
                    if isEditing && selectedImages.contains(index) {
                        Color.black.opacity(0.4)
                            .frame(width: 120, height: 120)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .onTapGesture {
                    if isEditing {
                        if selectedImages.contains(index) {
                            selectedImages.remove(index)
                        } else {
                            selectedImages.insert(index)
                        }
                    }
                }
            }
        }
        .padding()
    }
}


#Preview {
    MultiImagePickerView(currentImages: [])
}

