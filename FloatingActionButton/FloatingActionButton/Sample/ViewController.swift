//
//  ViewController.swift
//  FloatingActionButton
//
//  Created by Sara Mukali on 10.01.17.
//  Copyright © 2017 Sara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fab = FloatingActionButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        fab.add(on: self.view)
        fab.color = UIColor.blue
        fab.radius = 30
        fab.hasBlackout = true
        fab.blackoutColor = UIColor.gray
        fab.blackoutOpacity = 0.5
        fab.blackoutAnimationDuration = 0.2
        fab.hasShadow = true
        fab.hiddenType = .alpha
        
        fab.addAction { (item: FloatingActionButton) in
            let alert = UIAlertController(title: "Hello!", message: "Do you want to continue?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        fab.itemSpace = 15
//        fab.horizontalPosition = .right
        let item = FloatingActionButtonItem()
        item.color = UIColor.blue
        item.title = "Custom"
        fab.addItem(item: item)
        fab.itemRadius = 20
        fab.addItem(title: "With title")
        
        item.titleColor = UIColor.green
        
        fab.addItem(title: "With handler") { item in
            let alert = UIAlertController(title: "Hello!", message: "Do you want to continue?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        fab.addItem("With icon", icon: UIImage(named: "icMap"))
        fab.paddingY = 20
        fab.paddingX = 20
    }

    @IBAction func moveFAB(_ sender: UIButton) {
        fab.isHidden = true
    }
    
    @IBAction func returnFAB(_ sender: UIButton) {
        fab.isHidden = false
    }
}

