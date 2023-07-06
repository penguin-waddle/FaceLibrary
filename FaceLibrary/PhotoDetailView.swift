//
//  PhotoDetailView.swift
//  FaceLibrary
//
//  Created by Vivien on 5/3/23.
//
import CoreLocation
import MapKit
import SwiftUI
import UIKit

struct IdentifiableLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct PhotoDetailView: View {
    let photo: Photo
    
    @State private var scale: CGFloat = 1.0
    @State private var displayMode = 0
    @State private var region: MKCoordinateRegion
    
    init(photo: Photo) {
        self.photo = photo
        if let location = photo.location {
            _region = State(initialValue: MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        } else {
            _region = State(initialValue: MKCoordinateRegion())
        }
    }
    
    var body: some View {
        VStack {
            Picker("", selection: $displayMode) {
                Text("Image").tag(0)
                Text("Location").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            if displayMode == 0 {
                GeometryReader { geometry in
                    ScrollView([.horizontal, .vertical]) {
                        VStack {
                            Spacer(minLength: 20)
                            Image(uiImage: photo.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width)
                                .scaleEffect(scale)
                                .gesture(MagnificationGesture().onChanged { value in
                                    scale = value.magnitude
                                })
                            Spacer(minLength: 20)
                        }
                    }
                }
            } else {
                // Display the location
                if let location = photo.location {
                    Map(coordinateRegion: $region, annotationItems: [IdentifiableLocation(coordinate: location)]) { identifiableLocation in
                        MapMarker(coordinate: identifiableLocation.coordinate, tint: .red)
                    }
                    .edgesIgnoringSafeArea(.all)
                } else {
                    Text("No location data available")
                        .padding()
                }
            }
        }
        .navigationBarTitle(photo.photoName, displayMode: .inline)
    }
}


struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePhoto = Photo(photoName: "Sample", image: UIImage(systemName: "person.fill")!, location: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        PhotoDetailView(photo: samplePhoto)
    }
}
