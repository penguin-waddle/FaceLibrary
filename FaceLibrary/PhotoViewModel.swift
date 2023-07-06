//
//  PhotoViewModel.swift
//  FaceLibrary
//
//  Created by Vivien on 5/2/23.
//
import CoreLocation
import Foundation
import SwiftUI
import UIKit

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = []

    func loadPhotos() {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            let imageFileURLs = fileURLs.filter { $0.pathExtension.lowercased() == "jpg" }
            var loadedPhotos: [Photo] = []
            
            for url in imageFileURLs {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    let imageName = url.deletingPathExtension().lastPathComponent
                    
                    let locationFileURL = documentsDirectory.appendingPathComponent("\(imageName)_location.txt")
                    let locationData = try? String(contentsOf: locationFileURL)
                    let coordinates = locationData?.split(separator: ",").compactMap { CLLocationDegrees($0) }
                    var location: CLLocationCoordinate2D? = nil
                    if let lat = coordinates?.first, let lon = coordinates?.last {
                        location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    }
                    
                    let photo = Photo(photoName: imageName, image: image, location: location)
                    loadedPhotos.append(photo)
                }
            }
            
            photos = loadedPhotos.sorted { $0.photoName < $1.photoName }
        } catch {
            print("Error loading images from documents directory: \(error)")
        }
    }
    
    func deletePhoto(at offsets: IndexSet) {
           for index in offsets {
               let photo = photos[index]
               let fileManager = FileManager.default
               let photoURL = FileManager.documentsDirectory.appendingPathComponent("\(photo.photoName).jpg")
               
               do {
                   try fileManager.removeItem(at: photoURL)
               } catch {
                   print("Error deleting photo from documents directory: \(error)")
               }
           }
           
           photos.remove(atOffsets: offsets)
       }
}



