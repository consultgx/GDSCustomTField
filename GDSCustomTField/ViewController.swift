//
//  ViewController.swift
//  GDSCustomTField
//
//  Created by Gautam Dhall on 5/17/16.
//  Copyright © 2016 GautamD. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var txtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let newTextfield = GDSResizableTextfield()
        newTextfield.placeholderText = "Please enter here"
        newTextfield.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(newTextfield)
        
        self.view.addConstraint(NSLayoutConstraint(item: newTextfield, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.txtField, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: newTextfield, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.txtField, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: newTextfield, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.txtField, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: newTextfield, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.txtField, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: newTextfield, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 100))
        
        newTextfield.resizableTextShouldReturn = { (textfield: GDSResizableTextfield) -> Bool in
            self.txtField.text = newTextfield.text
            self.textFieldShouldReturn(self.txtField)
            newTextfield.text = self.txtField.text ?? ""
            return false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendClick(sender: AnyObject) {
    
    }
    
    
    internal func textFieldShouldReturn(textField: UITextField) -> Bool {
       // Do your Logic
        
        txtField.resignFirstResponder()
        textField.text = textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (textField.text == "")
        {
            return true
        }
       
        
        return true
    }
    
    @IBAction func valChanged(sender: AnyObject) {
        
        
    }
    
    
    @IBAction func touchUpInside(sender: AnyObject) {
        
        
    }
    
    
    
    

}