//
//  ImagePickerView.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/10/2023.
//

import SwiftUI

struct ImagePickerView: View {
    @Binding var isPresented: Bool
    @ObservedObject var tempUser: TemporaryUser
    @ObservedObject var userData: UserData
    @State var showSummaryView = false
    @State private var profilePhoto: UIImage?
    @State private var showImagePicker = false
    @State private var isButtonDisabled = true

    var body: some View {
        ZStack {
            Color("appPink").ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Text("Finalicemos con una foto de perfil.")
                    .font(.custom("Montserrat", size: 16))
                    .foregroundColor(Color.white)
                
                ZStack {
                    tempUser.image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .foregroundColor(Color("appYellow"))
                        Group {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: 200, height: 200)
                                .offset(y:150)
                            Text("EDITAR")
                                .offset(y:75)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            showImagePicker = true
                        }
                }
                .clipShape(Circle())
                
                NavigationLink(destination: SummaryView(isPresented: $isPresented, tempUser: tempUser, userData: userData), isActive: $showSummaryView) {
                    Text("Siguiente")
                        .padding()
                        .foregroundColor(.black)
                        .background(isButtonDisabled ? Color.gray : Color("appYellow"))
                        .cornerRadius(10)
                }
                .disabled(isButtonDisabled)
            }
            .padding()
            .autocorrectionDisabled()
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $profilePhoto)
            }
            .onChange(of: profilePhoto) { newImage in
                if let newImage = newImage {
                    tempUser.image = Image(uiImage: newImage)
                    tempUser.imageToSave = newImage
                }
                isButtonDisabled = false
            }
        }
    }
}
