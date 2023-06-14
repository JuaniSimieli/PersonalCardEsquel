//
//  SwiftUIView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/06/2023.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.04, blue: 0.04, opacity: 0.60)
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 320, height: 320)
                .foregroundColor(.white)
            SocialQRCodeView(social: .instagram, userData: UserData.defaultUser)
        }
        .ignoresSafeArea()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
