//
//  EditDataView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/06/2023.
//

import SwiftUI

struct EditDataView: View {
    @FocusState private var isFocusedField: Bool
    @ObservedObject var userData: UserData
    @State private var isEditingDisabled = true
    @State private var profilePhoto: UIImage?
    @State private var showImagePicker = false
    @State private var multipleImages: [UIImage] = []
    @State private var isShowingImagePicker: Bool = false
    @EnvironmentObject var userImages: UserImages
    @State private var showAlert = false
    @State private var isUsingCustomImages: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Spacer()
                    ZStack {
                        userData.image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .foregroundColor(Color("appPink"))
                        if isEditingDisabled == false {
                            Group {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .frame(width: 100, height: 100)
                                    .offset(y:80)
                                Text("EDITAR")
                                    .offset(y:42)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                            .onTapGesture {
                                showImagePicker = true
                            }
                        }
                    }
                    .clipShape(Circle())
                    Spacer()
                }
                .padding(.top , -10)
                .padding(.bottom, -10)
                .listRowBackground(Color.clear)
                
                Section {
                    HStack {
                        Text("Nombre")
                        TextField("Nombre", text: $userData.firstName)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Apellido")
                        TextField("Apellido", text: $userData.lastName)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Cargo")
                        TextField("Cargo", text: $userData.position)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Email \nPrincipal")
                        TextField("Email principal", text: $userData.email1)
                            .keyboardType(.emailAddress)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Email \nAlternativo")
                        TextField("Opcional", text: $userData.email2)
                            .keyboardType(.emailAddress)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Teléfono \nPrincipal")
                        TextField("Teléfono Personal", text: $userData.phone1)
                            .focused($isFocusedField)
                            .keyboardType(.phonePad)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Teléfono Secundario")
                        TextField("Teléfono Secundario", text: $userData.phone2)
                            .focused($isFocusedField)
                            .keyboardType(.phonePad)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                } header: {
                    Text("Datos Personales")
                } footer: {
                    Text("El email alternativo es opcional \nEn el teléfono secundario se muestra por defecto el número de la secretaría.")
                }
                .disabled(isEditingDisabled)
                .textInputAutocapitalization(.never)
                .submitLabel(.done)
                
                Toggle("Usar Imagenes Personalizadas", isOn: $isUsingCustomImages)
                    .onChange(of: isUsingCustomImages) { value in
                        if !value {
                            showAlert = true
                        } else if userImages.customImages.isEmpty {
                            isShowingImagePicker.toggle()
                        }
                    }
                if isUsingCustomImages {
                    Button("Agregar / Modificar Imagenes") {
                        //                    check .onTapGesture()
                    }
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .foregroundColor(.white)
                    .onTapGesture {
                        isShowingImagePicker.toggle()
                    }
                }
            }
            .autocorrectionDisabled()
            .toolbar {
                Button(isEditingDisabled ? "Editar" : "Aceptar") {
                    isEditingDisabled.toggle()
                    if userData.phone2.isEmpty {
                        userData.phone2 = "+5492945451927"
                    }
                }
            }
            .onTapGesture {
                isFocusedField = false
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $profilePhoto)
            }
            .sheet(isPresented: $isShowingImagePicker) {
                MultiImagePickerView(currentImages: userImages.customImages)
                    .environmentObject(userImages)
            }
            .onChange(of: profilePhoto) { newImage in
                if let newImage = newImage {
                    userData.image = Image(uiImage: newImage)
                    saveImage(image: newImage)
                }
            }
            .onAppear {
                // Asigna el valor basado en si hay imágenes customizadas al aparecer la vista
                isUsingCustomImages = !userImages.customImages.isEmpty
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Eliminar Imágenes"),
                      message: Text("¿Estás seguro de que quieres eliminar todas las fotos personalizadas de la app?"),
                      primaryButton: .destructive(Text("Eliminar")) {
                    userImages.customImages.removeAll()
                    isUsingCustomImages = false
                },
                      secondaryButton: .cancel() {isUsingCustomImages = true})
            }
        }
    }
    
    init(for userData: UserData) { self.userData = userData }
    
    func saveImage(image: UIImage) {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentDirectory.appendingPathComponent("userImage.jpg")
        
        do {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: filePath)
            }
        } catch {
            print("Error guardando imagen: \(error)")
        }
    }
}

struct EditDataView_Previews: PreviewProvider {
    static var previews: some View {
        EditDataView(for: UserData.defaultUser)
    }
}
