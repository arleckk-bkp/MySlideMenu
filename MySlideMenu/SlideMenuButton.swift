//
//  SlideMenuButton.swift
//  MySlideMenu
//
//  Created by Oscar Reynaldo Flores Jimenez on 06/05/17.
//  Copyright © 2017 Oscar Reynaldo Flores Jimenez. All rights reserved.
//

import UIKit

class SlideMenuButton: UIBarButtonItem {
    
    private static var isOpened = false
    private var superView: UIViewController!
    private var menuVC: MenuViewController!
    private var animation: Movement = .Basic
    
    init(superView: UIViewController, animation: Movement) {
        super.init()
        SlideMenuButton.isOpened = false
        self.target = self
        self.action = #selector(showMenu)
        self.menuVC = MenuViewController()
        self.superView = superView
        self.animation = animation
        self.superView.addChildViewController(self.menuVC)
        self.showMenu()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showMenu() {
        //is menu opened?
        //yes, so close it
        if !SlideMenuButton.isOpened {
            print("close menu")
            switch animation {
            
            case .Basic:
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.menuVC.view.removeFromSuperview()
                }, completion: { (finished) in
                    SlideMenuButton.isOpened = true
                })
                
                break
                
            case .LeftToRight:
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.menuVC.view.frame.origin.x = self.menuVC.view.frame.origin.x - self.menuVC.view.frame.size.width
                }, completion: { (finished) in
                    SlideMenuButton.isOpened = true
                })
                
                break
                
            default:
                break
            }
            
        }
        //is menu opened?
        //no, so open it
        else {
            print("open menu")
            switch animation {
                
            case .Basic:
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.superView.addChildViewController(self.menuVC)
                    self.superView.view.addSubview(self.menuVC.view)
                }, completion: { (finished) in
                    SlideMenuButton.isOpened = false
                })
                
                break
                
            case .LeftToRight:
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.superView.view.addSubview(self.menuVC.view)
                    self.menuVC.view.frame.origin.x = self.menuVC.view.frame.origin.x + self.menuVC.view.frame.size.width
                }, completion: { (finished) in
                    SlideMenuButton.isOpened = false
                })
                
                break
                
            default:
                break
            }
        }
    }
    
    enum Movement {
        case Basic
        case LeftToRight
    }

}
