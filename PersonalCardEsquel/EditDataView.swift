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
                    Text("Estos datos van a ser utilizados para mostrar en la pantalla principal y para actualizar el código QR para compartir tu contacto. \nEl email alternativo es opcional \nEn el teléfono secundario se muestra por defecto el número de la secretaría.")
                }
                .disabled(isEditingDisabled)
                
                Section {
                    HStack {
                        Text("Instagram")
                        TextField("Instagram", text: $userData.instragram)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    .disabled(isEditingDisabled)
                    HStack {
                        Text("Twitter")
                        TextField("Twitter", text: $userData.twitter)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    .disabled(isEditingDisabled)
                    HStack (spacing: 4) {
                        Text("Facebook")
                        Image(systemName: "questionmark.circle")
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                if let url = URL(string: "https://www.facebook.com/help/1503421039731588?helpref=platform_switcher&cms_platform=iphone-app&cms_id=1503421039731588") {
                                    UIApplication.shared.open(url)
                                }
                            }
                        TextField("Facebook", text: $userData.facebook)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                            .disabled(isEditingDisabled)
                    }
                } header: {
                    Text("Redes Sociales")
                } footer: {
                    Text("Si no modificas las redes sociales, se mostrarán por defecto las de Turismo Esquel. \nPara Instagram y Twitter poné tu nombre de usuario sin el arroba. \nPara Facebook necesitas tu identificador de página, si no sabés como obtenerlo, hacé click en el ícono azul (Esto abrirá la app de Facebook).")
                }
                .textInputAutocapitalization(.never)
                .submitLabel(.done)
            }
            .autocorrectionDisabled()
            .toolbar {
                Button(isEditingDisabled ? "Editar" : "Aceptar") {
                    isEditingDisabled.toggle()
                }
            }
            .onTapGesture {
                isFocusedField = false
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $profilePhoto)
            }
            .onChange(of: profilePhoto) { newImage in
                if let newImage = newImage {
                    userData.image = Image(uiImage: newImage)
                    saveImage(image: newImage)
                }
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
