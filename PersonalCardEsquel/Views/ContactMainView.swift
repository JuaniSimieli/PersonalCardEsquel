//
//  ContactMainView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/10/2023.
//

import SwiftUI

struct ContactMainView: View {
    @Binding var isPresented: Bool
    @ObservedObject var tempUser: TemporaryUser
    @ObservedObject var userData: UserData
    @State var showContactOptionalView = false
    var nextButtonDisabled: Bool {
        tempUser.email1.isEmpty ||
        tempUser.phone1.isEmpty
    }


    var body: some View {
        ZStack {
            Color("appPink").ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Text("Sigamos con tu email y tu numero de teléfono")
                    .font(.custom("Montserrat", size: 16))
                    .foregroundColor(Color.white)
                
                TextField("Email Principal", text: $tempUser.email1)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                TextField("Teléfono Principal", text: $tempUser.phone1)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                NavigationLink(destination: ContactOptionalView(isPresented: $isPresented, tempUser: tempUser, userData: userData), isActive: $showContactOptionalView) {
                    Text("Siguiente")
                        .padding()
                        .foregroundColor(.black)
                        .background(nextButtonDisabled ? Color.gray : Color("appYellow"))
                        .cornerRadius(10)
                }
                .disabled(nextButtonDisabled)
            }
            .padding()
            .autocorrectionDisabled()
        }
    }
}
