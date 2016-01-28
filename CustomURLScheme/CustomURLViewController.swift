//
//  ViewController.swift
//  CustomURLScheme
//
//  Created by jeff on 28/01/2016.
//  Copyright © 2016 jeff. All rights reserved.
//

import UIKit

class CustomURLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let urlQuery = appDelegate.urlQuery
        print(urlQuery)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

