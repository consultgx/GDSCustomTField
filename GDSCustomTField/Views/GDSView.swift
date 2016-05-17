
//  Created by Gautam Dhall on 5/17/16.
//  Copyright © 2016 GautamD. All rights reserved.
//

import UIKit

@IBDesignable
class GDSView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUp()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setUp()
	}
	
	func loadNibNamed(name: String) -> UIView {
		let nib = UINib(nibName: name, bundle: NSBundle(forClass: self.dynamicType))
		let v = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
		return v
	}
	
	func addNibToView(view: UIView) {
		self.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["v":view]))
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["v":view]))
	}
	
	func setUp() {
		
	}
}
class GDSResizableTextfield: GDSView, UITextViewDelegate {
    var placeholderText = String() { willSet { self._placeholderTextView.text = newValue } }
    var text: String {
        get { return self._textView.text }
        set {
            self._textView.text = newValue
            self.textViewDidChange(self._textView)
        }
    }
    private let _textView = UITextView()
    private let _placeholderTextView = UITextView()
    private var heightConstraint = NSLayoutConstraint()
    
    var resizableTextShouldReturn = {(textfield: GDSResizableTextfield) -> Bool in return false }
    
    override func setUp() {
        self.backgroundColor = .whiteColor()
        _placeholderTextView.textColor = .grayColor()
        _placeholderTextView.userInteractionEnabled = false
        let views = [_placeholderTextView, _textView]
        views.forEach({ $0.scrollEnabled })
        views.forEach(addSubview)
        views.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        views.forEach({ self.addConstraints(|->$0 + $0<-|) })
        views.forEach({ self.addConstraints(|-^$0 + $0^-|) })
        
        self.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 30)
        self.addConstraint(heightConstraint)
        
        _textView.delegate = self
        _textView.backgroundColor = .clearColor()
        _placeholderTextView.text = self.placeholderText
    }
    
    func textViewDidChange(textView: UITextView) {
        _placeholderTextView.hidden = !textView.text.isEmpty
        
        var shouldReturn: Bool = false
        if textView.text.characters.last == "\n" {
            shouldReturn = resizableTextShouldReturn(self)
        }
        
        if shouldReturn == false {
            if textView.text.characters.last == "\n" {
                textView.text = (textView.text as NSString).substringToIndex(textView.text.characters.count - 1)
            }
        }
        let size = textView.sizeThatFits(CGSize(width: estimatedWidth(), height: CGFloat.max))
        self.heightConstraint.constant = size.height
    }
    
    func estimatedWidth() -> CGFloat {
        if #available(iOS 9.0, *) {
            return self.frame.size.width
        } else {
            switch Int(UIScreen.mainScreen().bounds.width) {
            case 320: return 226
            case 375: return 274
            case 414: return 307
            default: return 226
            }
        }
    }
}

prefix operator |~| { }

prefix func |~|(rhs: UIView) {
    rhs.translatesAutoresizingMaskIntoConstraints = false
}

prefix operator |-^ { }
prefix func |-^(child: UIView) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[child]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: [ "child" : child ])
}

prefix func |-^(margin: Int) -> ( UIView -> [NSLayoutConstraint]) {
    return { (child: UIView) -> [NSLayoutConstraint] in
        return NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(margin)-[child]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: [ "child" : child ])
    }
}

//=====================

prefix operator |-> {  }
prefix func |->(child: UIView) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[child]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: [ "child" : child ])
}

prefix func |->(margin: Int)(_ child: UIView) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.constraintsWithVisualFormat("H:|-\(margin)-[child]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: [ "child" : child ])
}

//=====================

postfix operator ^-| { }
postfix func ^-|(child: UIView) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.constraintsWithVisualFormat("V:[child]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: [ "child" : child ])
}

postfix func ^-|(margin: Int) -> ( UIView -> [NSLayoutConstraint]) {
    return { (child: UIView) -> [NSLayoutConstraint] in
        return NSLayoutConstraint.constraintsWithVisualFormat("V:[child]-\(margin)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: [ "child" : child ])
    }
}

//======================

postfix operator <-| { }
postfix func <-|(child: UIView) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.constraintsWithVisualFormat("H:[child]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: [ "child" : child ])
}

postfix func <-|(margin: Int) -> ( UIView -> [NSLayoutConstraint]) {
    return { (child: UIView) -> [NSLayoutConstraint] in
        return NSLayoutConstraint.constraintsWithVisualFormat("H:[child]-\(margin)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: [ "child" : child ])
    }
}



