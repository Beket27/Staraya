//
//  DesignableView.swift
//  
//
//  Created by Beket on 11/18/17.
//

import UIKit

@IBDesignable class DesignableView: UIViewController {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
