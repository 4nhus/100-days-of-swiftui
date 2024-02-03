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
    
    let locationFetcher = LocationFetcher()
    
    @State private var uploadedPhoto: PhotosPickerItem?
    @State private var showNamePhoto = false
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
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker("Import photo", selection: $uploadedPhoto)
                }
            }
            .onChange(of: uploadedPhoto) {
                if uploadedPhoto != nil {
                    Task {
                        showNamePhoto = true
                        
                    }
                }
            }
        }
        .sheet(isPresented: $showNamePhoto) {
            Form {
                Section("Photo name") {
                    TextField("Name", text: $photoName)
                }
                Button("Save") {
                    savePhoto()
                    showNamePhoto = false
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
        .onAppear {
            locationFetcher.start()
        }
    }
    
    func savePhoto() {
        Task {
            guard let photoData = try? await uploadedPhoto?.loadTransferable(type: Data.self) else {
                failedPhotoImportMessage = "Failed to get data from imported photo"
                showFailedPhotoImport = true
                return
            }
            
            guard let location = locationFetcher.lastKnownLocation else {
                failedPhotoImportMessage = "Location permissions required to enable photo location tagging"
                showFailedPhotoImport = true
                return
            }
            
            photos.append(Photo(data: photoData, name: photoName, latitude: location.latitude, longitude: location.longitude))
            
            photoName = ""
            uploadedPhoto = nil
            
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
