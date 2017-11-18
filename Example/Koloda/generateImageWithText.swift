//
//  generateImageWithText.swift
//  Koloda_Example
//
//  Created by Beket on 11/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

func generateImageWithText(text: String) -> UIImage
{
    let image = UIImage(named: "imageWithoutText")!
    
    let imageView = UIImageView(image: image)
    imageView.backgroundColor = UIColor.clear
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height)
    
    let label = UILabel(frame: CGRectMake(0, 0, image.size.width, image.size.height))
    label.backgroundColor = UIColor.clearColor()
    label.textAlignment = .Center
    label.textColor = UIColor.whiteColor()
    label.text = text
    
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0);
    imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    label.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext();
    
    return imageWithText
}
