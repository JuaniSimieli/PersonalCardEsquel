//
//  BasicInfoView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/10/2023.
//

import SwiftUI

struct BasicInfoView: View {
    @Binding var isPresented: Bool
    @ObservedObject var tempUser: TemporaryUser
    @ObservedObject var userData: UserData
    @State var showContactMainView = false
    var nextButtonDisabled: Bool {
        tempUser.firstName.isEmpty ||
        tempUser.lastName.isEmpty ||
        tempUser.position.isEmpty
    }

    var body: some View {
        ZStack {
            Color("appPink").ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Text("Comencemos con tu Nombre, Apellido y tu cargo.")
                    .font(.custom("Montserrat", size: 16))
                    .foregroundColor(Color.white)
                
                TextField("Nombre", text: $tempUser.firstName)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                TextField("Apellido", text: $tempUser.lastName)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                TextField("Cargo", text: $tempUser.position)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                NavigationLink(destination: ContactMainView(isPresented: $isPresented, tempUser: tempUser, userData: userData), isActive: $showContactMainView) {
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
