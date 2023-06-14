//
//  ContentView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 10/06/2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct ContentView: View {
    @State private var isShowingQR = false
    @State private var isShowingSheet = false
    var userData = UserData.defaultUser
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ZStack {
                        colors
                        VStack (spacing: 0){
                            appImage
                            appStrings
                            contactCard
                            socialMedia
                            tabView
                            turismoData
                            Image(systemName: "gear")
                                .onTapGesture {
                                    isShowingSheet.toggle()
                                }
                        }
                    }
                }
            }
            if isShowingQR {
                socialQRShow //Cambiar esto por una animacion como la gente
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            EditDataView()
                .interactiveDismissDisabled()
        }
    }
    
    var colors: some View {
        VStack(spacing: 0) {
            Color.white
                .frame(height: 150)
            Color("appYellow")
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
    
    var appImage: some View {
        Image(systemName: "person.circle.fill") //chequear foto personal
            .resizable()
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 7)
            )
            .frame(width: 200, height: 200)
            .scaledToFit()
            .foregroundColor(Color("appPink"))
    } //Cambiar foto perfil
    
    var appStrings: some View {
        VStack {
            Text(userData.fullName)
            Text(userData.position)
            Text(userData.email)
        }
        .padding()
        .foregroundColor(Color("appPink"))
    }
    
    var contactCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("appPink"))
            VStack {
                ContactQRCodeView(userData: userData)
                    .padding()
                Text("Descargá mi contacto en tu celular")
                    .padding()
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
    
    var socialMedia: some View {
        Group {
            Text("Compartir redes Sociales")
                .padding()
                .foregroundColor(Color("appPink"))
            
            HStack (spacing: 30) {
                Image("recurso4")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .onTapGesture {
                        isShowingQR.toggle()
                    }
                Image("recurso4")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .onTapGesture {
                        isShowingQR.toggle()
                    }
                Image("recurso4")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .onTapGesture {
                        isShowingQR.toggle()
                    }
            }
            .padding(.bottom)
        }
    } //Chequear que iconos de redes mostrar
    
    var socialQRShow: some View {
        ZStack {
            Color(red: 0.04, green: 0.04, blue: 0.04, opacity: 0.70)
                .onTapGesture {
                    isShowingQR.toggle()
                }
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 320, height: 320)
                .foregroundColor(.white)
            SocialQRCodeView(social: .instagram, userData: userData)
        }
        .ignoresSafeArea()
    } //Modificar como llamar al qr de redes
    
    var tabView: some View {
        TabView {
            Image("galeria002")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .tag(1)
            Image("galeria003")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .tag(2)
            Image("galeria004")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .tag(3)
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("appPink"), lineWidth: 2)
        )
        .padding()
    } //Usa fotos predeterminadas, hacer dinamico
    
    var turismoData: some View {
        ZStack (alignment: .top) {
            ZStack {
                Rectangle()
                    .fill(Color("appPink"))
                    .padding(.bottom, -350)
            }
            
            VStack {
                Text("ESQUEL")
                    .font(.largeTitle)
                Text("SECRETARÍA DE TURISMO DE ESQUEL")
                    .font(.caption)
                Text("Telefonos: +54 2945 45-1927/45-5652")
                    .font(.caption)
                Text("Av. Alvear esq. Sarmiento, (9200)")
                    .font(.caption)
                Text("Esquel, Chubut, Argentina")
                    .font(.caption)
            }
            .padding()
            .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
