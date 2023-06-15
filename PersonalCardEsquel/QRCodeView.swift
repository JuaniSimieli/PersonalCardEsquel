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
        Image(uiImage: socialQR())
            .interpolation(.none)
            .resizable()
            .frame(width: 300, height: 300)
    }
    
    func socialQR() -> UIImage {
        var username = ""
        
        switch social {
        case .instagram:
            username = "instagram://user?username=\(handle)"
        case .facebook:
            username = "fb://profile/\(handle)"
        case .twitter:
            username = "twitter://user?screen_name=\(handle)"
        }
        
        let data = username.data(using: .utf8)
        
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

struct ContactQRCodeView: View {
    let userData: UserData
    
    var body: some View {
        Image(uiImage: contactQR(userData))
            .interpolation(.none)
            .resizable()
            .frame(width: 300, height: 300)
    }
    
    func contactQR(_ contactData: UserData) -> UIImage {
        let contactCard = """
        BEGIN:VCARD
        VERSION:4.0
        N:\(contactData.lastName);\(contactData.firstName)
        FN:\(contactData.firstName) \(contactData.lastName)
        TEL;TYPE=CELL:\(contactData.phone1)
        TEL;TYPE=WORK:\(contactData.phone2)
        EMAIL:\(contactData.email)
        URL:\(contactData.url)
        ADR:\(contactData.address)
        END:VCARD
        """

        let data = contactCard.data(using: .utf8)

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
    
    init(firstName: String, lastName: String, phone: String, email: String) {
        let newUser = UserData(firstName: firstName, lastName: lastName, position: "", email: email, phone1: phone)
        self.userData = newUser
    }
}
