//
//  ActivityIndicator.swift
//  GitHub
//
//  Created by Nitish.kumar on 25/06/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit


let kLoaderTagValue = 12134

extension UIView {
    func showLoader(with title: String = "") {
        
        let loaderWidth = title.isEmpty ? CGFloat(75) : CGFloat(180)
        let loaderHeight    =   CGFloat(75.0)
        let strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: loaderWidth, height: loaderHeight))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 1.0, alpha: 0.8)
        
        let effectView  =   UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        effectView.frame = CGRect(x: self.frame.midX - strLabel.frame.width/2, y: self.frame.midY - strLabel.frame.height/2 , width: loaderWidth, height: loaderHeight)
        effectView.layer.cornerRadius = 10
        effectView.layer.masksToBounds = true
        effectView.tag      =   kLoaderTagValue
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: loaderHeight, height: loaderHeight)
        activityIndicator.color =   UIColor.white
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        self.addSubview(effectView)
    }
    
    func hideLoader() {
        if let effectView = self.viewWithTag(kLoaderTagValue)  {
            effectView.removeFromSuperview()
        }
    }
}
