//
//  ContentView.swift
//  FriendFace
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    @State private var failedFetchMessage = ""
    @State private var showingFailedFetch = false
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(user.isActive ? .green : .gray.opacity(0.5))
                        Text(user.name)
                            .fontWeight(user.isActive ? .semibold : .regular)
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
            .navigationTitle("FriendFace")
        }
        .onAppear {
            Task {
                if users.count == 0 {
                    await fetchUsers()
                }
            }
        }
        .alert("Failed to fetch friends!",isPresented: $showingFailedFetch) {
            Button("Retry") {
                Task {
                    await fetchUsers()
                }
            }
        } message: {
            Text(failedFetchMessage)
        }
    }
    
    func fetchUsers() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        do {
            let (usersData, _): (Data, URLResponse) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            users = try JSONDecoder().decode([User].self, from: usersData)
        } catch {
            failedFetchMessage = error.localizedDescription
            showingFailedFetch = true
        }
    }
}

#Preview {
    ContentView()
}
