//
//  QRCodeView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 10/06/2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

enum SocialMediaType {
    case instagram, facebook, twitter
}

struct SocialQRCodeView: View {
    let social: SocialMediaType
    let handle: String
    
    var body: some View {
        Image(uiImage: QRCodeGenerator.generateQR(from: socialQR()))
            .interpolation(.none)
            .resizable()
            .frame(width: 300, height: 300)
    }
    
    func socialQR() -> String {
        var username = ""
        
        switch social {
        case .instagram:
            username = "instagram://user?username=\(handle)"
        case .facebook:
            username = "fb://profile/\(handle)"
        case .twitter:
            username = "twitter://user?screen_name=\(handle)"
        }
        
        return username
    }
}

struct ContactQRCodeView: View {
    let userData: UserData
    
    var body: some View {
        Image(uiImage: QRCodeGenerator.generateQR(from: contactVCard()))
            .interpolation(.none)
            .resizable()
            .frame(width: 300, height: 300)
    }
    
    func contactVCard() -> String {
            let contactCard = """
            BEGIN:VCARD
            VERSION:4.0
            N:\(userData.lastName);\(userData.firstName)
            FN:\(userData.firstName) \(userData.lastName)
            TEL;TYPE=CELL:\(userData.phone1)
            TEL;TYPE=WORK:\(userData.phone2)
            EMAIL:\(userData.email)
            URL:\(userData.url)
            ADR:\(userData.address)
            END:VCARD
            """

            return contactCard
        }
    
    init(firstName: String, lastName: String, phone: String, email: String) {
        let newUser = UserData(firstName: firstName, lastName: lastName, position: "", email: email, phone1: phone)
        self.userData = newUser
    }
}

struct QRCodeGenerator {
    static func generateQR(from string: String) -> UIImage {
        let data = string.data(using: .utf8)

        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            let context = CIContext()
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
