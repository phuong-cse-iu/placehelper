//
//  RightImageViewTxtField.swift
//  PlaceHelper
//
//  Created by TranTPhuong on 2/16/17.
//  Copyright © 2017 Trunky Foundation. All rights reserved.
//

import UIKit

class RightImageViewTxtField: UITextField {
    
    // Provides left padding for images
//    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//        var textRect = super.leftViewRect(forBounds: bounds)
//        textRect.origin.x += leftPadding
//        return textRect
//    }
    @IBInspectable var rightPadding:CGFloat = 0
//    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightPadding
        return textRect
    }
    
    @IBInspectable var rightImage:UIImage? {
        didSet {
            updateViewWithRightMode()
        }
    }
    
    @IBInspectable var color:UIColor = UIColor.lightGray {
        didSet {
            updateViewWithRightMode()
        }
    }
    
    func updateViewWithRightMode() {
        if let image = rightImage {
            rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x:0, y:0, width: 15, height:15))
            imageView.image = image
            
            imageView.tintColor = color
            rightView = imageView
        } else  {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
        
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSForegroundColorAttributeName: color])
        
    }
    
    
//    @IBInspectable var leftImage: UIImage? {
//        didSet {
//            updateView()
//        }
//    }
    
    
//    @IBInspectable var leftPadding: CGFloat = 0
    
//    @IBInspectable var color: UIColor = UIColor.lightGray {
//        didSet {
//            updateView()
//        }
//    }
    
//    func updateView() {
//        if let image = leftImage {
//            leftViewMode = UITextFieldViewMode.always
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//            imageView.image = image
//            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
//            imageView.tintColor = color
//            leftView = imageView
//        } else {
//            leftViewMode = UITextFieldViewMode.never
//            leftView = nil
//        }
//        
//        // Placeholder text color
//        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSForegroundColorAttributeName: color])
//    }
    
}
