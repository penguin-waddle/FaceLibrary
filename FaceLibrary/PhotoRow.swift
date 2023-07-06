//
//  PhotoRow.swift
//  FaceLibrary
//
//  Created by Vivien on 5/3/23.
//
import CoreLocation
import SwiftUI
import UIKit

struct PhotoRow: View {
    @ObservedObject var photo: Photo
    
    var body: some View {
        HStack {
            Image(uiImage: photo.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            TextField("Name", text: $photo.photoName)
                .font(.headline)
        }
    }
}


struct PhotoRow_Previews: PreviewProvider {
    static var previews: some View {
        let examplePhoto = Photo(photoName: "Example", image: UIImage(systemName: "person.fill")!, location: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        PhotoRow(photo: examplePhoto)
    }
}
