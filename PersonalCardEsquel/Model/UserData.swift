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
    @Published var email1: String
    @Published var email2: String
    @Published var phone1: String
    @Published var phone2: String
    @Published var image: Image = Image(systemName: "person.circle.fill")
    
    var fullName: String {
        firstName + " " + lastName
    }
    
    init(firstName: String, lastName: String, position: String, email1: String, email2: String = "", phone1: String, phone2: String = "+5492945451927") {
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.email1 = email1
        self.email2 = email2
        self.phone1 = phone1
        self.phone2 = phone2
    }
    
    static let defaultUser = UserData(firstName: "Juan", lastName: "Perez", position: "Secretario", email1: "juanperez@esquel.gov.ar", phone1: "+5492945000000")
    
    enum CodingKeys: CodingKey {
            case firstName, lastName, position, email1, email2, phone1, phone2
        }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        position = try container.decode(String.self, forKey: .position)
        email1 = try container.decode(String.self, forKey: .email1)
        email2 = try container.decode(String.self, forKey: .email2)
        phone1 = try container.decode(String.self, forKey: .phone1)
        phone2 = try container.decode(String.self, forKey: .phone2)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(position, forKey: .position)
        try container.encode(email1, forKey: .email1)
        try container.encode(email2, forKey: .email2)
        try container.encode(phone1, forKey: .phone1)
        try container.encode(phone2, forKey: .phone2)
    }
}
