//
//  SummaryView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/10/2023.
//

import SwiftUI

struct SummaryView: View {
    @Binding var isPresented: Bool
    @ObservedObject var tempUser: TemporaryUser
    @ObservedObject var userData: UserData

    var body: some View {
        ZStack {
            Color("appPink").ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Text("Todo listo, \(tempUser.firstName.uppercased())")
                    .font(.custom("Montserrat-SemiBold", size: 24))
                    .foregroundColor(Color.white)
                Text("Podras cambiar tus datos en la configuración mas tarde si lo deseas.")
                    .multilineTextAlignment(.center)
                    .font(.custom("Montserrat", size: 16))
                    .foregroundColor(Color.white)
                
                Button("Finalizar") {
                    userData.firstName = tempUser.firstName
                    userData.lastName = tempUser.lastName
                    userData.position = tempUser.position
                    userData.email1 = tempUser.email1
                    userData.email2 = tempUser.email2
                    userData.phone1 = tempUser.phone1
                    if !tempUser.phone2.isEmpty {
                        userData.phone2 = tempUser.phone2
                    }
                    saveImage(image: tempUser.imageToSave)
                    userData.image = tempUser.image

                    isPresented = false
                }
                .padding()
                .foregroundColor(.black)
                .background(Color("appYellow"))
                .cornerRadius(10)
            }
            .padding()
        }
    }
    
    
    func saveImage(image: UIImage) {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentDirectory.appendingPathComponent("userImage.jpg")
        
        do {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: filePath)
            }
        } catch {
            print("Error guardando imagen: \(error)")
        }
    }
}
