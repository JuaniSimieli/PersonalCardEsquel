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
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var position = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var instagram = ""
    @State private var facebook = ""
    @State private var twitter = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Datos personales") {
                    TextField("Nombre", text: $firstName)
                        .focused($isFocusedField)
                    TextField("Apellido", text: $lastName)
                        .focused($isFocusedField)
                    TextField("Puesto", text: $position)
                        .focused($isFocusedField)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .focused($isFocusedField)
                    TextField("Telefono personal", text: $phone)
                        .focused($isFocusedField)
                        .keyboardType(.phonePad)
                }
                
                Section {
                    TextField("Instagram", text: $instagram)
                        .focused($isFocusedField)
                    TextField("Facebook", text: $facebook)
                        .focused($isFocusedField)
                    TextField("Twitter", text: $twitter)
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
                    //validar datos
                }
            }
            .onTapGesture {
                isFocusedField = false
            }
        }
    }
}

struct EditDataView_Previews: PreviewProvider {
    static var previews: some View {
        EditDataView()
    }
}
