//
//  Title.swift
//  UnitConverter
//
//  Created by Anh Nguyen on 30/1/2024.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func largeTitle() -> some View {
        modifier(Title())
    }
}
