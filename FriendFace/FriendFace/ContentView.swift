//
//  ContentView.swift
//  FriendFace
//
//  Created by Anh Nguyen on 1/2/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    @State private var failedFetchMessage = ""
    @State private var showingFailedFetch = false
    @State private var loadedData = false
    
    var body: some View {
        NavigationStack {
            Group {
                if loadedData {
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
                } else {
                    List {
                        
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
            .navigationTitle("FriendFace")
        }
        .onAppear {
            //try? modelContext.delete(model: User.self)
            
            Task {
                if users.count == 0 {
                    await fetchUsers()
                }
                
                loadedData = true
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
            let decodedUsers = try JSONDecoder().decode([User].self, from: usersData)
            decodedUsers.forEach { user in
                modelContext.insert(user)
            }
        } catch {
            failedFetchMessage = error.localizedDescription
            showingFailedFetch = true
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: User.self)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
