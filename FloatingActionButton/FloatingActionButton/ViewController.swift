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
        fab.add(on: self.view)
        fab.color = UIColor.yellow
        fab.tappedButtonChangedColor = UIColor.purple
        fab.radius = 40
        fab.hasBlackout = true
        fab.blackoutColor = UIColor.blue
        fab.blackoutOpacity = 0.5
        fab.hasShadow = true
        
        fab.addAction { (item: FloatingActionButton) in
            let alert = UIAlertController(title: "Hello!", message: "Do you want to continue?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        fab.itemSpace = 20
        fab.horizontalPosition = .left
        let item = FloatingActionButtonItem()
        item.color = UIColor.blue
        item.title = "Custom"
        fab.addItem(item: item)
        fab.itemRadius = 30
        fab.addItem(title: "With title")
        
        item.titleColor = UIColor.green
        
        fab.addItem(title: "With handler") { item in
            let alert = UIAlertController(title: "Hello!", message: "Do you want to continue?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        fab.addItem("With icon", icon: UIImage(named: "icMap"))
        fab.paddingY = 50
        fab.paddingX = 35
    }
}

