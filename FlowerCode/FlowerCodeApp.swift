//
//  FlowerCodeApp.swift
//  FlowerCode
//
//  Created by 刘畅 on 2022/7/5.
//

import SwiftUI

@main
struct FlowerCodeApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var modelData = ModelData()


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(modelData)
        }
    }
}
