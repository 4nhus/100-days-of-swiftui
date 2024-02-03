//
//  ContentView.swift
//  FaceTagger
//
//  Created by Anh Nguyen on 2/2/2024.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    static let photosURL = URL.documentsDirectory.appending(path: "photos.json")
    
    @State private var uploadedPhoto: PhotosPickerItem?
    @State private var showPhotoNaming = false
    @State private var photoName = ""
    @State private var photos = (try? JSONDecoder().decode([Photo].self, from: Data(contentsOf: photosURL))) ?? [Photo]()
    @State private var showFailedPhotoImport = false
    @State private var failedPhotoImportMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List(photos) { photo in
                    NavigationLink(value: photo) {
                        Image(uiImage: UIImage(data: photo.data)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(photo.name)
                    }
                }
                .navigationDestination(for: Photo.self) { photo in
                    PhotoView(photo: photo)
                }
            }
            .navigationTitle("FaceTagger")
            .toolbar {
                PhotosPicker("Import photo", selection: $uploadedPhoto)
            }
            .onChange(of: uploadedPhoto) {
                Task {
                    showPhotoNaming = true
                }
            }
        }
        .sheet(isPresented: $showPhotoNaming) {
            Form {
                Section("Name the photo") {
                    TextField("Photo name", text: $photoName)
                }
                Button("Save") {
                    savePhoto()
                    showPhotoNaming = false
                }
                .disabled(photoName.isEmpty)
            }
            .onDisappear {
                uploadedPhoto = nil
            }
        }
        .alert("Unable to import photo", isPresented: $showFailedPhotoImport) { } message: {
            Text(failedPhotoImportMessage)
        }
        .onChange(of: showPhotoNaming) { oldValue, newValue in
            if oldValue == true {
                
            }
        }
    }
    
    func savePhoto() {
        Task {
            guard let photoData = try? await uploadedPhoto?.loadTransferable(type: Data.self) else {
                failedPhotoImportMessage = "Failed to get data from imported photo"
                showFailedPhotoImport = true
                return }
            
            photos.append(Photo(data: photoData, name: photoName))
            
            guard let savedPhotosData = try? JSONEncoder().encode(photos) else {
                failedPhotoImportMessage = "Failed to encode photo for saving"
                showFailedPhotoImport = true
                return
            }
            
            do {
                try savedPhotosData.write(to: ContentView.photosURL, options: [.atomic, .completeFileProtection])
            } catch {
                failedPhotoImportMessage = "Failed to save photo"
                showFailedPhotoImport = true
            }
        }
    }
}

#Preview {
    ContentView()
}
