//
//  FileManagerService.swift
//  Assignment10
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
class FileManagerService {
    
    static func getDocDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Doc Dir: \(paths[0])")
        return paths[0]
    }
    
    static func getFiles() -> Array<String>{
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var filesArray = [String]()
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: paths, includingPropertiesForKeys: nil)
            for f in fileURLs {
                
                //if f.pathExtension == ".txt" {
                    filesArray.append(f.lastPathComponent)
                //}
            }
            print("All Files : ",fileURLs)
           
        } catch {
            print("Error while enumerating files \(paths.path): \(error.localizedDescription)")
            
        }
        return filesArray
    }
}
