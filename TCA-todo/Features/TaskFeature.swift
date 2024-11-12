//
//  Task.swift
//  TCA-todo
//
//  Created by Kuba on 11/11/24.
//

import ComposableArchitecture

@Reducer
struct TaskFeature {
    
    @ObservableState struct State: Equatable {
        var isCompleted = false
        var name: String?
        var isLoading = false
        var count = 0
        var isTimerRunning = false
    }
    
    enum Action {
        case toggleCompleted
        case randomTitleButtonTapped
        case randomTitleResponse(String)
        case timerTick
        case timerStopped
        case toggleTimerButtonTapped
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.taskTitle) var taskTitle
    
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
                    let randomIndex = Int.random(in: 0...3)
                    try await send(.randomTitleResponse(self.taskTitle.fetch(randomIndex)))
                }
            case let .randomTitleResponse(name):
                state.name = name
                state.isLoading = false
                return .none
            case .timerTick:
                state.count += 1
                return .none
            case .timerStopped:
                state.count = 0
                state.isTimerRunning = false
                return .none
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        for await _ in self.clock.timer(interval: .seconds(1)) {
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                } else {
                    return .cancel(id: CancelID.timer).merge(
                        with: .run { send in
                            await send(.timerStopped)
                    })
                }
            }
        }
    }
}
