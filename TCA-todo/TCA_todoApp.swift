//
//  TCA_todoApp.swift
//  TCA-todo
//
//  Created by Kuba on 11/11/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_todoApp: App {
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: TCA_todoApp.store)
        }
    }
}
