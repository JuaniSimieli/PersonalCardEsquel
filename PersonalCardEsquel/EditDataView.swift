//
//  EditDataView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/06/2023.
//

import SwiftUI

struct EditDataView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocusedField: Bool
    @ObservedObject var userData: UserData
    
    var body: some View {
        NavigationView {
            Form {
                Section("Datos Personales") {
                    TextField("Nombre", text: $userData.firstName)
                        .focused($isFocusedField)
                    TextField("Apellido", text: $userData.lastName)
                        .focused($isFocusedField)
                    TextField("Puesto", text: $userData.position)
                        .focused($isFocusedField)
                    TextField("Email", text: $userData.email)
                        .keyboardType(.emailAddress)
                        .focused($isFocusedField)
                    TextField("Telefono personal", text: $userData.phone1)
                        .focused($isFocusedField)
                        .keyboardType(.phonePad)
                }
                
                Section {
                    TextField("Instagram", text: $userData.instragram)
                        .focused($isFocusedField)
                    TextField("Facebook", text: $userData.facebook)
                        .focused($isFocusedField)
                    TextField("Twitter", text: $userData.twitter)
                        .focused($isFocusedField)
                } header: {
                    Text("Redes Sociales")
                } footer: {
                    Text("No inlcluyas arrobas")
                }
                .textInputAutocapitalization(.never)
                .submitLabel(.done)
            }
            .autocorrectionDisabled()
            .navigationTitle("Datos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Guardar") {
                    dismiss()
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
