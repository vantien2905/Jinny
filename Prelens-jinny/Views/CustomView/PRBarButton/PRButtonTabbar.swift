//
//  PRButtonTabbar.swift
//  Prelens-jinny
//
//  Created by Lamp on 5/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol PRTabbarButtonDelegate: class {
    func btnTapped(name: String)
}

class PRButtonTabbar: PRBaseViewXib {

    @IBOutlet weak var imvIcon: UIImageView!
    @IBOutlet weak var lbCounter: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnIconTapped: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbCounter.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 2.5)
        
    }
    
    weak var tabbarButtonDelegate: PRTabbarButtonDelegate?
    
    func setNotificationCounter(count: Int) {
        if count == 0 {
            self.lbCounter.isHidden = true
        } else {
            self.lbCounter.isHidden = false
            lbCounter.text = count.description
        }
    }
    
    func setTitle(title: String) {
        lbTitle.text = title
    }
    
    func setIcon(image: UIImage) {
        self.imvIcon.contentMode = .scaleAspectFit
        self.imvIcon.image = image
    }
    
    func setTitleAndIcon(count: Int, image: UIImage) {
        setNotificationCounter(count: count)
        setIcon(image: image)
    }
}

//MARK: Button Action
extension PRButtonTabbar {
    @IBAction func buttonTapped() {
        tabbarButtonDelegate?.btnTapped(name: lbTitle.text!)
    }
}
