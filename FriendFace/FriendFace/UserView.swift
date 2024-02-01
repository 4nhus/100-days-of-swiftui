//
//  UserView.swift
//  FriendFace
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        VStack {
            List {
                Section("About") {
                    Text("Age:\n\(user.age)")
                    Text("Email:\n\(user.email)")
                    Text("Address:\n\(user.address)")
                    Text("About:\n\(user.about)")
                    Text("Registered:\n \(user.registered.formatted())")
                }
                
                Section("Tags") {
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
                
                Section("Friends") {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                }
                
            }
        }
        .navigationTitle(user.name)
    }
}

