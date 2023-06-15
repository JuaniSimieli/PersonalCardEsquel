//
//  UserDefaultsExtension.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 15/06/2023.
//

import Foundation
import SwiftUI

extension UserDefaults {
    func saveCustomObject(customObject object: UserData, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: key)
        }
    }
    
    func retrieveCustomObject(key: String) -> UserData? {
        guard let savedData = self.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        if let loaded = try? decoder.decode(UserData.self, from: savedData) {
            return loaded
        }
        return nil
    }
}
