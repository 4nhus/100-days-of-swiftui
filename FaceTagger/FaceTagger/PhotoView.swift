//
//  PhotoView.swift
//  FaceTagger
//
//  Created by Anh Nguyen on 3/2/2024.
//

import SwiftUI
import MapKit

struct PhotoView: View {
    let photo: Photo
    let initialPosition: MapCameraPosition
    
    init(photo: Photo) {
        self.photo = photo
        initialPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: photo.latitude, longitude: photo.longitude),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
    }
    
    var body: some View {
        Group {
            Map(initialPosition: initialPosition) {
                Annotation(photo.name, coordinate: CLLocationCoordinate2D(latitude: photo.latitude, longitude: photo.longitude)) {
                    Image(uiImage: UIImage(data: photo.data)!)
                        .resizable()
                        .frame(width: 44, height: 44)
                        .background(.white)
                        .padding(1)
                        .clipShape(.circle)
                }
            }
            Image(uiImage: UIImage(data: photo.data)!)
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(photo.name)
    }
}
