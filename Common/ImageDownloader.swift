//
//  ImageDownloader.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//


import Foundation
import UIKit

typealias imageComletion = (_ image : UIImage?,_ error : Error?)-> Void

class imageDownloader {
    
    static var handler : imageComletion!

    static let imageCache  = NSCache<NSString, UIImage>()
    static let operationQueue = OperationQueue()
    
    class func downloadImage(imageURL : String, handler : @escaping imageComletion) {
        self.handler    =   handler
        
        guard let url = URL(string: imageURL) else {
            return self.handler(nil, Errors(message: Constants.NetworkError.inValidURLError))
        }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.handler?(cachedImage, nil)
        }else {
            let operation = BlockOperation()
            operation.addExecutionBlock {
                do {
                    let imageData = try Data(contentsOf: url)
                    if let downloadedImage = UIImage(data: imageData) {
                        imageCache.setObject(downloadedImage, forKey: "\(imageURL)" as NSString)
                        handler(downloadedImage,nil)
                    }
                } catch {
                    return self.handler(nil, Errors(message: Constants.NetworkError.inValidURLError))
                }
            }
            imageDownloader.operationQueue.addOperation(operation)
        }
    }
}

