//
//  QRCodeView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 12/10/2023.
//

import SwiftUI

struct QRCodeView: View {
    var selectedSocialMediatoShow: SocialMediaType
    var handle: String {
        switch selectedSocialMediatoShow {
        case .facebook: return "Facebook"
        case .instagram: return "Instagram"
        case .twitter: return "Twitter"
        }
    }

    var body: some View {
        ZStack {
            Color("appYellow").ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Image("\(handle).icon")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .padding(.leading)
                    VStack(alignment: .leading){
                        Text("¡Descubrí")
                            .font(.custom("Montserrat-SemiBold", size: 24))
                            .foregroundColor(Color("appPink"))
                        Text("Turismo Esquel")
                            .font(.custom("Montserrat-Bold", size: 24))
                            .foregroundColor(Color("appPink"))
                        HStack {
                            Text("en")
                                .font(.custom("Montserrat-SemiBold", size: 24))
                                .foregroundColor(Color("appPink"))
                            Text("\(handle)!")
                                .font(.custom("Montserrat-Bold", size: 24))
                                .foregroundColor(Color("appPink"))
                        }
                    }
                    .padding()
                }
                
                Group {
                    switch selectedSocialMediatoShow {
                    case .facebook: SocialQRCodeView(social: .facebook, handle: "100064319754293") //Default FB Handle Turismo Esquel
                    case .instagram: SocialQRCodeView(social: .instagram, handle: "turismoesquelok")
                    case .twitter: SocialQRCodeView(social: .twitter, handle: "TurismoEsquel")
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("appPink"), lineWidth: 7)
                )
                .padding()
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    QRCodeView(selectedSocialMediatoShow: .instagram)
}
