//
//  FileManagerExtension.swift
//  FaceLibrary
//
//  Created by Vivien on 5/2/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
