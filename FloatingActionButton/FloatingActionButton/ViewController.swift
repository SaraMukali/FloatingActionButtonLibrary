//
//  ViewController.swift
//  FloatingActionButton
//
//  Created by Sara Mukali on 10.01.17.
//  Copyright © 2017 Sara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fab = FloatingActionButton()
        fab.color = UIColor.green
        fab.radius = 40
        fab.image = nil
        fab.paddingY = 100
        fab.hasBlackout = true
        fab.hasShadow = true
        fab.add(on: self.view)
    }
}

