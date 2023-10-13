//
//  PersonalCardEsquelApp.swift
//  PersonalCardEsquel
//
//  Created by Juani Simieli on 10/06/2023.
//

import SwiftUI

@main
struct PersonalCardEsquelApp: App {
    @StateObject private var userImages = UserImages()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(userImages)
        }
    }
}
