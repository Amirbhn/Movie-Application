//
//  ViewController.swift
//  Project IOS 2 Json Modified Verison
//
//  Created by Map04 on 2021-04-13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MovieApi.shared.fetchRootObject()
    }


}

