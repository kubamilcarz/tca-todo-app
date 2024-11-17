//
//  ContactsView.swift
//  TCA-todo
//
//  Created by Kuba on 11/14/24.
//

import ComposableArchitecture
import SwiftUI

struct ContactsView: View {
    
    let store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    Text(contact.name)
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                Button("Add", systemImage: "plus") {
                    store.send(.addButtonTapped)
                }
            }
        }
    }
}


#Preview {
    ContactsView(store: Store(initialState: ContactsFeature.State(
        contacts: [
          Contact(id: UUID(), name: "Blob"),
          Contact(id: UUID(), name: "Blob Jr"),
          Contact(id: UUID(), name: "Blob Sr"),
        ]
    )) {
        ContactsFeature()
    })
}
