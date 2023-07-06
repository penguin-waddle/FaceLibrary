//
//  AddPhotoView.swift
//  FaceLibrary
//
//  Created by Vivien on 5/1/23.
//
import CoreImage
import CoreLocation
import SwiftUI

struct AddPhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var photoViewModel: PhotoViewModel
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var photoName = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @StateObject private var locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                TextField("Please enter a name.", text: $photoName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Save") {
                    guard let inputImage = inputImage, !photoName.isEmpty else { return }
                    
                    let imageSaver = ImageSaver()
                    let location = locationFetcher.lastKnownLocation
                    imageSaver.writeToDisk(image: inputImage, imageName: photoName, location: location ?? nil) { error in
                        if let error = error {
                            alertTitle = "Error"
                            alertMessage = error.localizedDescription
                            showingAlert = true
                        } else {
                            alertTitle = "Success"
                            alertMessage = "Image saved successfully."
                            showingAlert = true
                            photoViewModel.loadPhotos()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding([.horizontal, .bottom])
            .onAppear {
                locationFetcher.start()
            }
            .navigationTitle("Add New Friend")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        let examplePhotoViewModel = PhotoViewModel()
        AddPhotoView(photoViewModel: examplePhotoViewModel)
    }
}
