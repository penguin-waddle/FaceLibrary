//
//  ContentView.swift
//  FaceLibrary
//
//  Created by Vivien on 5/1/23.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var photoViewModel = PhotoViewModel()
    @State private var isShowingAddPhotoView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(photoViewModel.photos) { photo in
                    NavigationLink(destination: PhotoDetailView(photo: photo)) {
                        PhotoRow(photo: photo)
                    }
                }
                .onDelete(perform: photoViewModel.deletePhoto)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Face Library")
            .onAppear {
                photoViewModel.loadPhotos()
            }
            .navigationBarItems(trailing:
                Button(action: {
                    isShowingAddPhotoView.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isShowingAddPhotoView) {
                AddPhotoView(photoViewModel: photoViewModel)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

