//
//  ContactOptionalView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/10/2023.
//

import SwiftUI

struct ContactOptionalView: View {
    @Binding var isPresented: Bool
    @ObservedObject var tempUser: TemporaryUser
    @ObservedObject var userData: UserData
    @State var showImagePickerView = false

    var body: some View {
        ZStack {
            Color("appPink").ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Text("Si lo deseas, puedes colocar un email y un teléfono alternativo.\nSi no colocas ningún teléfono alternativo se mostrará por defecto el numero de la secretaría de turismo.")
                    .font(.custom("Montserrat", size: 16))
                    .foregroundColor(Color.white)
                
                TextField("Email Alternativo", text: $tempUser.email2)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                TextField("Teléfono Alternativo", text: $tempUser.phone2)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                NavigationLink(destination: ImagePickerView(isPresented: $isPresented, tempUser: tempUser, userData: userData), isActive: $showImagePickerView) {
                    Text("Siguiente")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color("appYellow"))
                        .cornerRadius(10)
                }
            }
            .padding()
            .autocorrectionDisabled()
        }
    }
}
