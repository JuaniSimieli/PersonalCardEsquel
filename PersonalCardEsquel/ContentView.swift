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
    @StateObject var userData = UserData.defaultUser
    @State private var selectedSocialMediatoShow: SocialMediaType = .twitter
    @State private var iconScale = 1.0
    @State private var rotationAngle = 0.0
    
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
            EditDataView(userData)
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
                ContactQRCodeView(firstName: userData.firstName, lastName: userData.lastName, phone: userData.phone1, email: userData.email)
                    .padding()
                ZStack {
                    Text("Descargá mi contacto en tu celular")
                        .padding(.bottom)
                    .foregroundColor(.white)
                    HStack {
                        Spacer()
                        Image("flecha")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                            .offset(x: -10, y: -30)
                            .padding(.bottom, -15)
                            .padding(.top, -20)
                            .rotationEffect(Angle(degrees: rotationAngle), anchor: .bottomLeading)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                                    rotationAngle = 8.0
                                }
                            }
                    }
                }
            }
        }
        .padding()
    } //Agregar flecha
    
    var socialMedia: some View {
        Group {
            Text("Compartir redes Sociales")
                .padding()
                .foregroundColor(Color("appPink"))
            
            HStack (spacing: 30) {
                Image("instagram.icon") // Instagram
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedSocialMediatoShow = .instagram
                        isShowingQR.toggle()
                    }
                    .scaleEffect(iconScale)
                
                Image("twitter.icon") // Twitter
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedSocialMediatoShow = .twitter
                        isShowingQR.toggle()
                    }
                    .scaleEffect(iconScale)
                
                Image("facebook.icon") // Facebook
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedSocialMediatoShow = .facebook
                        isShowingQR.toggle()
                    }
                    .scaleEffect(iconScale)
            }
            .padding(.bottom)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.75).repeatForever()) {
                    iconScale = 1.1
                }
            }
        }
    }
    
    var socialQRShow: some View {
        ZStack {
            Color(red: 0.04, green: 0.04, blue: 0.04, opacity: 0.70)
                .onTapGesture {
                    isShowingQR.toggle()
                }
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 320, height: 320)
                .foregroundColor(.white)
            switch selectedSocialMediatoShow {
            case .facebook: SocialQRCodeView(social: .facebook, handle: userData.facebook)
            case .instagram: SocialQRCodeView(social: .instagram, handle: userData.instragram)
            case .twitter: SocialQRCodeView(social: .twitter, handle: userData.twitter)
            }
        }
        .ignoresSafeArea()
    }
    
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
    } //Modificar fuentes
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
