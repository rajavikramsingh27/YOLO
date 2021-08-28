//
//  Decoration_View.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 21/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class Decoration_View: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}



@IBDesignable
class Decoration_Button: UIButton {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}



@IBDesignable
class Decoration_Image:UIImageView {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}


@IBDesignable
class Decoration_TextField: UITextField {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue ?? UIColor.white])
        }
    }

    @IBInspectable var insetX: CGFloat = 6 {
       didSet {
         layoutIfNeeded()
       }
    }
    @IBInspectable var insetY: CGFloat = 6 {
       didSet {
         layoutIfNeeded()
       }
    }

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }
    
}



@IBDesignable
class Decoration_TextView:UITextView {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var topInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: topInset, left: self.contentInset.left, bottom: self.contentInset.bottom, right: self.contentInset.right)
        }
    }
    
    @IBInspectable var bottmInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: bottmInset, right: self.contentInset.right)
        }
    }
    
    @IBInspectable var leftInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: leftInset, bottom: self.contentInset.bottom, right: self.contentInset.right)
        }
    }
    
    @IBInspectable var rightInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: self.contentInset.bottom, right: rightInset)
        }
    }
    
}
