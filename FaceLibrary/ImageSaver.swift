//
//  ImageSaver.swift
//  FaceLibrary
//
//  Created by Vivien on 5/2/23.
//
import CoreLocation
import Foundation
import UIKit

class ImageSaver: NSObject {
    func writeToDisk(image: UIImage, imageName: String, location: CLLocationCoordinate2D?, completion: @escaping (Error?) -> Void) {
        let imagePath = FileManager.documentsDirectory.appendingPathComponent("\(imageName).jpg")
        let locationPath = FileManager.documentsDirectory.appendingPathComponent("\(imageName)_location.txt")
        
        let locationString: String
        if let location = location {
            locationString = "\(location.latitude),\(location.longitude)"
        } else {
            locationString = "Unknown Location"
        }
        
        guard let jpegData = image.jpegData(compressionQuality: 0.8) else {
            completion(NSError(domain: "ImageSaver", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to JPEG data"]))
            return
        }
        
        do {
            try jpegData.write(to: imagePath, options: [.atomic, .completeFileProtection])
            try locationString.write(to: locationPath, atomically: true, encoding: .utf8)
            completion(nil)
        } catch {
            completion(error)
        }
    }
}




