//
//  TemporaryUser.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 11/10/2023.
//

import Foundation
import SwiftUI

class TemporaryUser: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var position: String = ""
    @Published var email1: String = ""
    @Published var email2: String = ""
    @Published var phone1: String = ""
    @Published var phone2: String = ""
    @Published var image: Image = Image(systemName: "person.circle.fill")
    @Published var imageToSave: UIImage = UIImage()
}
