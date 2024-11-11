//
//  Task.swift
//  TCA-todo
//
//  Created by Kuba on 11/11/24.
//

import ComposableArchitecture

@Reducer
struct TaskFeature {
    
    @ObservableState struct State {
        var isCompleted = false
        var name: String
    }
    
    enum Action {
        case toggleCompleted
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .toggleCompleted:
                state.isCompleted.toggle()
                return .none
            }
        }
    }
}
