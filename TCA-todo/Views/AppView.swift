//
//  AppView.swift
//  TCA-todo
//
//  Created by Kuba on 11/12/24.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView {
            Tab("Task 1", systemImage: "checkmark.square") {
                TaskCellView(store: store.scope(state: \.tab1, action: \.tab1))
            }
            
            Tab("Task 2", systemImage: "checkmark.circle") {
                TaskCellView(store: store.scope(state: \.tab2, action: \.tab2))
            }
        }
    }
}


#Preview {
    AppView(store: Store(initialState: AppFeature.State(), reducer: {
        AppFeature()
    }))
}
