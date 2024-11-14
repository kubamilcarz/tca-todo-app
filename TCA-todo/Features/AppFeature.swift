//
//  AppFeature.swift
//  TCA-todo
//
//  Created by Kuba on 11/12/24.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    
    struct State: Equatable {
        var tab1 = TaskFeature.State()
        var tab2 = TaskFeature.State()
    }
    
    enum Action {
        case tab1(TaskFeature.Action)
        case tab2(TaskFeature.Action)
    }
    
    
    var body: some ReducerOf<Self> {
        Scope(state: \.tab1, action: \.tab1) {
            TaskFeature()
        }
        Scope(state: \.tab2, action: \.tab2) {
            TaskFeature()
        }
        Reduce { state, action in
            return .none
        }
    }
}
