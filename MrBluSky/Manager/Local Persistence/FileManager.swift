//
//  FileManager.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 18/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit


extension FileManager {
    static let sharedInstance = FileManager()
    
    public static var documentsDirectoryURL: URL {
        return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
    }
    public static func fileURLInDocumentDirectory(_ fileName: String) -> URL {
        return self.documentsDirectoryURL.appendingPathComponent(fileName)
    }
    
    func saveImage(_ path: String, image: UIImage) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let documentPath = documentsURL.path
        
        let filePath = documentsURL.appendingPathComponent(path)
        
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: "\(documentPath)")
            for file in files {
                if "\(documentPath)\(file)" == filePath.path {
                    try FileManager.default.removeItem(atPath: filePath.path)
                }
            }
        } catch {
            print("error")
        }
        
        do {
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: filePath)
            }
        } catch {
            print("aaa")
        }
    }
    
    func getDiretoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths.first!
        
        return documentsDirectory
    }

    
    func getImageFrom(path: String) -> UIImage? {
        let fileManager = FileManager.default
        let imagePath = (self.getDiretoryPath() as NSString).strings(byAppendingPaths: [path]).first!
        if fileManager.fileExists(atPath: imagePath) {
            return UIImage(contentsOfFile: imagePath)
        }
        return nil 
    }
    
    func removeFromFileManagerWith(path: String) {
        let fileManeger = FileManager.default
        let imagePath = (self.getDiretoryPath() as NSString).strings(byAppendingPaths: [path]).first!
        
        try? fileManeger.removeItem(atPath: imagePath)
    }
    
}
