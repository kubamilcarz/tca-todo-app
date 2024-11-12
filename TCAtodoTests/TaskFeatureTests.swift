//
//  TCAtodoTests.swift
//  TCAtodoTests
//
//  Created by Kuba on 11/12/24.
//

import Testing
import ComposableArchitecture

@testable import TCA_todo

@MainActor
struct TCAtodoTests {

    @Test
    func basics() async throws {
        let store = TestStore(initialState: TaskFeature.State()) {
            TaskFeature()
        }
        
        await store.send(.toggleCompleted) {
            $0.isCompleted = true
        }
        
        await store.send(.toggleCompleted) {
            $0.isCompleted = false
        }
    }
    
    @Test
    func timer() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: TaskFeature.State()) {
            TaskFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }

        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        
        await clock.advance(by: .seconds(1))
        
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
        
        await store.receive(\.timerStopped) {
            $0.count = 0
            $0.isTimerRunning = false
        }
    }

    @Test
    func numberFact() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: TaskFeature.State()) {
            TaskFeature()
        } withDependencies: {
            $0.taskTitle.fetch = { "\($0) is a good number." }
            $0.continuousClock = clock
        }
        
        await store.send(.randomTitleButtonTapped) {
            $0.isLoading = true
        }
        await clock.advance(by: .seconds(2))
        
        await store.receive(\.randomTitleResponse) {
            $0.isLoading = false
            $0.name = "0 is a good number."
        }
        
    }
}
