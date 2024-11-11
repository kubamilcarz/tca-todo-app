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
        var name: String?
        var isLoading = false
    }
    
    enum Action {
        case toggleCompleted
        case randomTitleButtonTapped
        case randomTitleResponse(String)
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .toggleCompleted:
                state.isCompleted.toggle()
                return .none
            case .randomTitleButtonTapped:
                state.isLoading = true
                state.name = nil

                return .run { send in
                    // perform network fetching of a title
                    try? await Task.sleep(for: .seconds(2))
                    
                    let randomName = ["Random todo", "Clean bedroom", "Throw out trash", "Organize desk"].shuffled().first!
                    await send(.randomTitleResponse(randomName))
                }
            case let .randomTitleResponse(name):
                state.name = name
                state.isLoading = false
                return .none
            }
        }
    }
}
