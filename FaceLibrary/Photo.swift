//
//  Photo.swift
//  FaceLibrary
//
//  Created by Vivien on 5/3/23.
//
import CoreLocation
import Foundation
import SwiftUI
import UIKit

class Photo: Identifiable, ObservableObject {
    let id = UUID()
    @Published var photoName: String
    let image: UIImage
    let location: CLLocationCoordinate2D?
    
    init(photoName: String, image: UIImage, location: CLLocationCoordinate2D?) {
        self.photoName = photoName
        self.image = image
        self.location = location
    }
}
