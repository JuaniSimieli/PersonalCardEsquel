//
//  InitialSetupView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/10/2023.
//

import SwiftUI

struct InitialSetupView: View {
    @Binding var isPresented: Bool
    @ObservedObject var userData: UserData
    @StateObject var tempUser = TemporaryUser()
    @State var showBasicInfoView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("appPink").ignoresSafeArea(.all)
                VStack(spacing: 20) {
                    Text("Bienvenido a la app de Tarjeta Personal ESQUEL")
                        .font(.custom("Montserrat-SemiBold", size: 24))
                        .foregroundColor(Color.white)
                    Text("Para comenzar vamos a pedirte tus datos para que puedas usar la app")
                        .multilineTextAlignment(.center)
                        .font(.custom("Montserrat", size: 16))
                        .foregroundColor(Color.white)
                    NavigationLink(destination: BasicInfoView(isPresented: $isPresented, tempUser: tempUser, userData: userData), isActive: $showBasicInfoView) {
                        EmptyView()
                    }
                    Button("Continuar") {
                        showBasicInfoView = true
                    }
                    .padding()
                    .background(Color("appYellow"))
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
                }
                .padding()
            }
        }
        .accentColor(Color("appYellow"))
    }
}
