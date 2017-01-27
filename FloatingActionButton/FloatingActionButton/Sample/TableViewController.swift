//
//  TableViewController.swift
//  FloatingActionButton
//
//  Created by Sara on 1/25/17.
//  Copyright © 2017 Sara. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var fab = FloatingActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fab.color = UIColor.green
        
        fab.radius = 40
        fab.isSticky = true
        fab.paddingY = 100
        fab.hasBlackout = true
        fab.tappedButtonChangedColor = UIColor.purple
        
        fab.hasShadow = true
        fab.horizontalPosition = .left
        fab.addAction { (item: FloatingActionButton) in
            let alert = UIAlertController(title: "Hello!", message: "Do you want to continue?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        fab.itemRadius = 25
        fab.itemSpace = 20
        
        let item = FloatingActionButtonItem()
        item.color = UIColor.blue
        item.title = "Custom"
        fab.addItem(item: item)
        
        fab.addItem(title: "With title")
        fab.add(on: self.view)
        
        item.titleColor = UIColor.green
        
        fab.addItem(title: "With handler") { item in
            let alert = UIAlertController(title: "Hello!", message: "Do you want to continue?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        fab.addItem("With icon", icon: UIImage(named: "icMap"))
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == 49 {
            fab.color = UIColor.brown
            fab.setHidden(.move)
        }
        return cell
    }
}
