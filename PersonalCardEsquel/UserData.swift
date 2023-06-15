//
//  UserData.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 13/06/2023.
//

import Foundation
import SwiftUI

class UserData: ObservableObject {
    @Published var firstName: String
    @Published var lastName: String
    @Published var position: String
    @Published var email: String
    @Published var phone1: String
    @Published var instragram: String = "turismoesquelok"
    @Published var facebook: String = "100064319754293" // Turismo Esquel
    @Published var twitter: String = "TurismoEsquel"
    let phone2 = "+5492945451927"
    let url = "www.esquel.tur.ar"
    let address = "Sarmiento y Avenida Alvear, 9200 Esquel, Chubut, Argentina"
    
    @Published var image: Image = Image(systemName: "person.circle.fill")
    
    
    var fullName: String {
        firstName + " " + lastName
    }
    
    init(firstName: String, lastName: String, position: String, email: String, phone1: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.email = email
        self.phone1 = phone1
    }
    
    static let defaultUser = UserData(firstName: "Juan", lastName: "Perez", position: "Secretario", email: "juanperez@esquel.gov.ar", phone1: "2945000000")
}
