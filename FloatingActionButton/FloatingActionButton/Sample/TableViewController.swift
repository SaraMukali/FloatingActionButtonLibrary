//
//  TableViewController.swift
//  FloatingActionButton
//
//  Created by Sara on 1/31/17.
//  Copyright © 2017 Sara. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var fab = FloatingActionButton()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fab.add(on: self.view)
        fab.color = UIColor.green
        fab.tappedButtonChangedColor = UIColor.darkGray
        fab.radius = 40
        fab.hasBlackout = true
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = String(indexPath.row)
        
        if indexPath.row == 29 {
            fab.setHidden(withType: .move, withAnimationDuration: 1)
        }
        
        return cell!
    }
}
