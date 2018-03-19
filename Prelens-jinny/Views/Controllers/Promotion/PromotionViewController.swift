//
//  PromotionViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController {
    @IBOutlet weak var vContainMenu: UIView!
    let vMenu:MenuView = {
        let view = MenuView()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listItemMenu = [
            MenuItem(title: "All", isSelected: true),
            MenuItem(title: "Stared", isSelected: false),
            MenuItem(title: "Archived", isSelected: false)
        ]
        //controllers = [ vcSignUp, vcSignIn ]
        self.vMenu.setUpMenuView(menuColorBackground: .clear, listItem: listItemMenu)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setupView(){
        configMenuView()
    }
    private func configMenuView(){
        self.vContainMenu.addSubview(vMenu)
        vMenu.delegate = self
        vMenu.fillSuperview()
    }
}

extension PromotionViewController: MenuBarDelegate {
    func itemMenuSelected(index: Int) {
            print(index)
    }
}

