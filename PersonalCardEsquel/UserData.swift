//
//  UserData.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 13/06/2023.
//

import Foundation
import SwiftUI

class UserData: ObservableObject, Codable {
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
    
    static let defaultUser = UserData(firstName: "Juan", lastName: "Perez", position: "Secretario", email: "juanperez@esquel.gov.ar", phone1: "+54 9 2945 00 0000")
    
    enum CodingKeys: CodingKey {
            case firstName, lastName, position, email, phone1, instragram, facebook, twitter
        }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        position = try container.decode(String.self, forKey: .position)
        email = try container.decode(String.self, forKey: .email)
        phone1 = try container.decode(String.self, forKey: .phone1)
        instragram = try container.decode(String.self, forKey: .instragram)
        facebook = try container.decode(String.self, forKey: .facebook)
        twitter = try container.decode(String.self, forKey: .twitter)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(position, forKey: .position)
        try container.encode(email, forKey: .email)
        try container.encode(phone1, forKey: .phone1)
        try container.encode(instragram, forKey: .instragram)
        try container.encode(facebook, forKey: .facebook)
        try container.encode(twitter, forKey: .twitter)
    }
}
