//
//  FileManagerRepository.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/9/24.
//

import UIKit
import RealmSwift

final class FileManagerRepository {
    private static let manager = FileManager.default
    private static let directory: URL? = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    static func addImage(_ image: UIImage, _ filename: ObjectId) {
        guard let directory, let data = image.jpegData(compressionQuality: 0.5) else { return }
        let fileURL = directory.appendingPathComponent("\(filename).jpg")
        
        do {
            try data.write(to: fileURL)
            print("Image Add Completed")
        } catch {
            print("Error Add Image: \(error.localizedDescription)")
        }
    }
    
    static func loadImage(_ filename: ObjectId) -> UIImage? {
        guard let directory else { return nil }
        let fileURL = directory.appendingPathComponent("\(filename).jpg")
        guard manager.fileExists(atPath: fileURL.path()) else { return nil }
        
        return UIImage(contentsOfFile: fileURL.path())
    }
    
    static func removeImage(_ filename: ObjectId) {
        guard let directory else { return }
        let fileURL = directory.appendingPathComponent("\(filename).jpg")
        guard manager.fileExists(atPath: fileURL.path()) else { return }
        
        do {
            try manager.removeItem(atPath: fileURL.path())
            print("Image Delete Completed")
        } catch {
            print("Error Delete Image: \(error.localizedDescription)")
        }
    }
}
