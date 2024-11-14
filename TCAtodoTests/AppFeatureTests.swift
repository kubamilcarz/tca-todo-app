//
//  AppFeatureTests.swift
//  TCA-todo
//
//  Created by Kuba on 11/12/24.
//

import ComposableArchitecture
import Testing


@testable import TCA_todo


@MainActor
struct AppFeatureTests {
    
    @Test
    func toggleInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(\.tab1.toggleCompleted) {
            $0.tab1.isCompleted = true
        }
    }
}
