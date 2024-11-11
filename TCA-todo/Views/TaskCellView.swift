//
//  TaskCellView.swift
//  TCA-todo
//
//  Created by Kuba on 11/11/24.
//

import ComposableArchitecture
import SwiftUI

struct TaskCellView: View {
    let store: StoreOf<TaskFeature>
    
    var body: some View {
        HStack {
            Button {
                store.send(.toggleCompleted)
            } label: {
                HStack {
                    Image(systemName: store.isCompleted ? "checkmark.square.fill" : "square")
                        .font(.title3.weight(.medium))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(store.isCompleted ? Color.accentColor : .secondary)
                    
                    Text(store.name)
                        .font(.headline)
                        .strikethrough(store.isCompleted)
                        .foregroundStyle(store.isCompleted ? .secondary : .primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(.background.opacity(0.01))
            }
            .buttonStyle(.plain)
            
            Button {
                
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.regularMaterial, in: .rect(cornerRadius: 9))
    }
}


#Preview {
    TaskCellView(store: Store(initialState: TaskFeature.State(name: "")) {
        TaskFeature()
    })
    .padding()
}
