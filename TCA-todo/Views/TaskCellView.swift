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
        VStack(alignment: .trailing, spacing: 0) {
            HStack {
                Button {
                    store.send(.toggleCompleted)
                } label: {
                    HStack {
                        Image(systemName: store.isCompleted ? "checkmark.square.fill" : "square")
                            .font(.title3.weight(.medium))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(store.isCompleted ? Color.accentColor : .secondary)
                        
                        Text(store.name ?? "Shuffle todo...")
                            .font(.headline)
                            .strikethrough(store.isCompleted)
                            .foregroundStyle(store.isCompleted ? .secondary : .primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .background(.background.opacity(0.01))
                }
                .buttonStyle(.plain)
                
                
                if store.isLoading {
                    ProgressView()
                } else {
                    Button {
                        store.send(.randomTitleButtonTapped)
                    } label: {
                        Image(systemName: "shuffle")
                            .foregroundStyle(.secondary)
                    }
                    .disabled(store.isLoading)
                }
            }
            .padding()
            .background(.thinMaterial, in: .rect(cornerRadius: 9))
            
            HStack {
                if store.isTimerRunning {
                    Text(store.count.formatted())
                        .font(.headline)
                        .contentTransition(.numericText())
                        .padding(.horizontal)
                }
                
                Spacer()
                
                Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                    store.send(.toggleTimerButtonTapped)
                }
                .buttonStyle(.borderedProminent)
                .padding(5)
            }
        }
        .background(.regularMaterial, in: .rect(cornerRadius: 9))
    }
}


#Preview {
    TaskCellView(store: Store(initialState: TaskFeature.State()) {
        TaskFeature()
    })
    .padding()
}
