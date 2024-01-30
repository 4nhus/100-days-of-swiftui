//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Anh Nguyen on 30/1/2024.
//

import SwiftUI

struct FlagImage: View {
    let flag: String
    
    var body: some View {
        Image(flag)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}
