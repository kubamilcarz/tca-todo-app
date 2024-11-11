//
//  ContentView.swift
//  TCA-todo
//
//  Created by Kuba on 11/11/24.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TaskCellView(store: Store(initialState: TaskFeature.State(name: "bla"), reducer: {
                TaskFeature()
                    ._printChanges()
            }))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
