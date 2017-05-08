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
    private var firstTime = true
    private var superView: UIViewController!
    private var menuViewController: UIViewController!
    //private var menuVC: MenuViewController!
    private var animation: Animation = .Basic
    private var topConstraint: NSLayoutConstraint!
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    
    init(superView: UIViewController, animation: Animation) {
        super.init()
        SlideMenuButton.isOpened = false
        self.target = self
        self.action = #selector(showMenu)
        self.menuViewController = MenuViewController()
        self.superView = superView
        self.animation = animation
        self.superView.addChildViewController(self.menuViewController)
        self.showMenu()
    }
    
    init(superView: UIViewController, animation: Animation, menuView: UIViewController) {
        super.init()
        SlideMenuButton.isOpened = false
        self.target = self
        self.action = #selector(showMenu)
        self.superView = superView
        self.animation = animation
        self.menuViewController = menuView
        self.superView.addChildViewController(self.menuViewController)
        self.showMenu()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addMenuView() {
        topConstraint = NSLayoutConstraint(item: self.menuViewController.view, attribute: .top, relatedBy: .equal, toItem: self.superView.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        leadingConstraint = NSLayoutConstraint(item: self.menuViewController.view, attribute: .leading, relatedBy: .equal, toItem: self.superView.view, attribute: .leading, multiplier: 1, constant: 0)
        trailingConstraint = NSLayoutConstraint(item: self.menuViewController.view, attribute: .trailing, relatedBy: .equal, toItem: self.superView.view, attribute: .trailing, multiplier: 1, constant: 0)
        bottomConstraint = NSLayoutConstraint(item: self.menuViewController.view, attribute: .bottom, relatedBy: .equal, toItem: self.superView.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.superView.view.addSubview(self.menuViewController.view)
        self.superView.view.addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
    
    func removeMenuView() {
        if !firstTime {
            self.superView.view.removeConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
        }
        self.menuViewController.view.removeFromSuperview()
        firstTime = false
        SlideMenuButton.isOpened = true
    }
    
    func showMenu() {
        //is menu opened?
        //yes, so close it
        if !SlideMenuButton.isOpened {
            print("close menu")
            switch animation {
            
            case .Basic:
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.menuViewController.view.removeFromSuperview()
                }, completion: { (finished) in
                    SlideMenuButton.isOpened = true
                })
                
                break
                
            case .LeftToRight:
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.menuViewController.view.frame.origin.x = self.menuViewController.view.frame.origin.x - self.superView.view.frame.size.width
                }, completion: { (finished) in
                    self.removeMenuView()
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
                    self.superView.addChildViewController(self.menuViewController)
                    self.superView.view.addSubview(self.menuViewController.view)
                }, completion: { (finished) in
                    SlideMenuButton.isOpened = false
                })
                
                break
                
            case .LeftToRight:
                
                UIView.animate(withDuration: 0.5, animations: {
//                    self.superView.view.addSubview(self.menuVC.view)
                    self.addMenuView()
                    self.menuViewController.view.frame.origin.x = self.menuViewController.view.frame.origin.x + self.superView.view.frame.size.width
                    print(self.superView.view.frame.size.width)
                }, completion: { (finished) in
                    SlideMenuButton.isOpened = false
                })
                
                break
                
            default:
                break
            }
        }
    }
    
    enum Animation {
        case Basic
        case LeftToRight
    }

}
