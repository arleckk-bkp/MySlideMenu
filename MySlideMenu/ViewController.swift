//
//  ViewController.swift
//  MySlideMenu
//
//  Created by Oscar Reynaldo Flores Jimenez on 06/05/17.
//  Copyright © 2017 Oscar Reynaldo Flores Jimenez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var menuButton = SlideMenuButton(superView: self, animation: .LeftToRight)
        var menuButton = SlideMenuButton(superView: self, animation: .LeftToRight, menuView: SimpleMenuViewController())
        
        self.navigationItem.leftBarButtonItem = menuButton
        menuButton.image = UIImage(named: "menu")
        
        self.view.backgroundColor = UIColor.blue
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

