//
//  ViewController.swift
//  NSURL-Validation-Demo
//
//  Created by James Hickman on 11/18/14.
//  Copyright (c) 2014 NitWit Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide web view until valid URL is entered
        self.webView.hidden = true

        // Add notification observer for text field updates
        self.textField.addTarget(self, action: "textFieldDidUpdate:", forControlEvents: UIControlEvents.EditingChanged)
        
        // Demo UI Settings

    }

    override func viewWillAppear(animated: Bool)
    {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Text Field Delegate
    func textFieldDidUpdate(textField: UITextField)
    {
        // Remove Spaces
        textField.text = textField.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
        
        // Validate URL
        NSURL.validateUrl(textField.text, completion: { (success, urlString, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if (success)
                {
                    self.webView.hidden = false
                    var request = NSURLRequest(URL: NSURL(string: urlString!)!)
                    self.webView.loadRequest(request)
                }
                else
                {
                    self.webView.stopLoading()
                    self.webView.hidden = true
                }
            })
        })
    }
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.resignFirstResponder()
        self.view.endEditing(true)
    }
}

