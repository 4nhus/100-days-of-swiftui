//
//  EditView.swift
//  HotProspects
//
//  Created by Anh Nguyen on 5/2/2024.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var prospect: Prospect
    @State private var name = ""
    @State private var email = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField(prospect.name, text: $name)
                        .textContentType(.name)
                }
                
                Section("Email") {
                    TextField(prospect.emailAddress, text: $email)
                        .textContentType(.emailAddress)
                }
            }
            .navigationTitle("Edit contact")
            .toolbar {
                Button("Save") {
                    prospect.name = name
                    prospect.emailAddress = email
                    dismiss()
                }
                .disabled(name.isBlank || email.isBlank)
            }
        }
    }
}

extension String {
    var isBlank: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
