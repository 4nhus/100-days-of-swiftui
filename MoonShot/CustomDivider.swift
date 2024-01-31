//
//  CustomDivider.swift
//  MoonShot
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    CustomDivider()
}
