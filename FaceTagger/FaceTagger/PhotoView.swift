//
//  PhotoView.swift
//  FaceTagger
//
//  Created by Anh Nguyen on 3/2/2024.
//

import SwiftUI

struct PhotoView: View {
    let photo: Photo
    
    var body: some View {
        Image(uiImage: UIImage(data: photo.data)!)
            .resizable().scaledToFit()
            .navigationTitle(photo.name)
    }
}
