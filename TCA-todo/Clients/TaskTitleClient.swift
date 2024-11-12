//
//  TaskTitleClient.swift
//  TCA-todo
//
//  Created by Kuba on 11/12/24.
//

import ComposableArchitecture
import Foundation

struct TaskTitleClient {
    var fetch: (Int) async throws -> String
}


extension TaskTitleClient: DependencyKey {
  static let liveValue = Self(
    fetch: { number in
        try? await Task.sleep(for: .seconds(2))
        
        let names = ["Random todo", "Clean bedroom", "Throw out trash", "Organize desk"]
        
        let randomName = number > names.count ? names.first! : names[number]
        return randomName
    }
  )
}

extension DependencyValues {
    var taskTitle: TaskTitleClient {
        get { self[TaskTitleClient.self] }
        set { self[TaskTitleClient.self] = newValue }
    }
}
