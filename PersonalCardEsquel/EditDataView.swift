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
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Nombre")
                        TextField("Nombre", text: $userData.firstName)
                            .focused($isFocusedField)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Apellido")
                        TextField("Apellido", text: $userData.lastName)
                            .focused($isFocusedField)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Puesto")
                        TextField("Puesto", text: $userData.position)
                            .focused($isFocusedField)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Email")
                        TextField("Email", text: $userData.email)
                            .keyboardType(.emailAddress)
                            .focused($isFocusedField)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Teléfono Personal")
                        TextField("Teléfono Personal", text: $userData.phone1)
                            .focused($isFocusedField)
                            .keyboardType(.phonePad)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                } header: {
                    Text("Datos Personales")
                } footer: {
                    Text("Estos datos van a ser utilizados para mostrar en la pantalla principal y para actualizar el código QR para compartir tu contacto")
                }
                .disabled(isEditingDisabled)
                
                Section {
                    HStack {
                        Text("Instagram")
                        TextField("Instagram", text: $userData.instragram)
                            .focused($isFocusedField)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Twitter")
                        TextField("Twitter", text: $userData.twitter)
                            .focused($isFocusedField)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack (spacing: 4) {
                        Text("Facebook")
                        Image(systemName: "questionmark.circle")
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                // Facebook ID Help
                            }
                        TextField("Facebook", text: $userData.facebook)
                            .focused($isFocusedField)
                            .foregroundColor(isEditingDisabled ? .gray : .blue)
                            .multilineTextAlignment(.trailing)
                    }
                } header: {
                    Text("Redes Sociales")
                } footer: {
                    Text("Si no modificas las redes sociales, se mostrarán por defecto las de Turismo Esquel. \nPara Instagram y Twitter poné tu nombre de usuario sin el arroba. \nPara Facebook necesitas tu identificador de página, si no sabés como obtenerlo, hacé click en el ícono azul.")
                }
                .textInputAutocapitalization(.never)
                .submitLabel(.done)
                .disabled(isEditingDisabled)
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
        }
    }
    
    init(_ userData: UserData) { self.userData = userData }
}

struct EditDataView_Previews: PreviewProvider {
    static var previews: some View {
        EditDataView(UserData.defaultUser)
    }
}
