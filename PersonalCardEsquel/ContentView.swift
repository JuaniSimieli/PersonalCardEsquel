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
                                .padding(.top)
                        }
                    }
                }
            }
            if isShowingQR {
                socialQRShow
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            EditDataView(for: userData)
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
        userData.image
            .resizable()
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 7)
            )
            .frame(width: 200, height: 200)
            .scaledToFit()
            .foregroundColor(Color("appPink"))
    }
    
    var appStrings: some View {
        VStack {
            Text(userData.fullName)
                .font(.custom("Montserrat-SemiBold", size: 24))
            Text(userData.position)
                .font(.custom("Montserrat", size: 18))
            Text(userData.email)
                .font(.custom("Montserrat-SemiBold", size: 16))
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
                    VStack {
                        HStack (spacing: 5) {
                            Text("Descargá mi")
                                .font(.custom("Montserrat", size: 18))
                            Text("contacto")
                                .font(.custom("Montserrat-Bold", size: 18))
                        }
                        HStack (spacing: 5) {
                            Text("en")
                                .font(.custom("Montserrat", size: 18))
                            Text("tu celular")
                                .font(.custom("Montserrat-Bold", size: 18))
                        }
                    }
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
                            .animation(.easeInOut(duration: 0.7).repeatForever(), value: rotationAngle)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            rotationAngle = 5.0
        }
    }
    
    var socialMedia: some View {
        Group {
            Text("Compartir redes Sociales")
                .padding()
                .foregroundColor(Color("appPink"))
                .font(.custom("Montserrat-SemiBold", size: 18))
            
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
    }
    
    var turismoData: some View {
        ZStack (alignment: .top) {
            ZStack {
                Rectangle()
                    .fill(Color("appPink"))
                    .padding(.bottom, -350)
            }
            
            VStack {
                Text("ESQUEL")
                    .font(.custom("JosefinSans-Bold", size: 50))
                    .padding(.top)
                Text("SECRETARÍA DE TURISMO DE ESQUEL")
                    .font(.custom("Montserrat-SemiBold", size: 12))
                Text("Telefonos: +54 2945 45-1927/45-5652")
                    .font(.custom("Montserrat", size: 12))
                Text("Av. Alvear esq. Sarmiento, (9200)")
                    .font(.custom("Montserrat", size: 12))
                Text("Esquel, Chubut, Argentina")
                    .font(.custom("Montserrat", size: 12))
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
