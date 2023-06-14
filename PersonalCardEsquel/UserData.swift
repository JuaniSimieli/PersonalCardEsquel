//
//  UserData.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 13/06/2023.
//

import Foundation

class UserData {
    var firstName: String
    var lastName: String
    var position: String
    var email: String
    var phone1: String
    var phone2 = "+5492945451927"
    var url = "www.esquel.tur.ar"
    var address = "Sarmiento y Avenida Alvear, 9200 Esquel, Chubut, Argentina"
    var instragram: String
    var facebook: String
    var twitter: String
    
    
    var fullName: String {
        firstName + " " + lastName
    }
    
    init(firstName: String, lastName: String, position: String, email: String, phone1: String, instragram: String? = nil, facebook: String? = nil, twitter: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.email = email
        self.phone1 = phone1
        self.instragram = instragram ?? "TurismoEsquel"
        self.facebook = facebook ?? "TurismoEsquel"
        self.twitter = twitter ?? "TurismoEsquel"
    }
    
    static let defaultUser = UserData(firstName: "Juan", lastName: "Perez", position: "Secretario", email: "juanperez@esquel.gov.ar", phone1: "2945000000", instragram: "TurismoEsquel", facebook: "TurismoEsquel", twitter: "TurismoEsquel")
}
