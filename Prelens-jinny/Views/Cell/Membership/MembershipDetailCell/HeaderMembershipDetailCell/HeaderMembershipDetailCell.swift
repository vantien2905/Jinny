//
//  HeaderMembershipDetailCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage

class HeaderMembershipDetailCell: UITableViewCell {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var imgBarcode: UIImageView!
    @IBOutlet weak var lbCodeNumber: UILabel!
    
    @IBAction func btnLogoTapped() {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(urlLogo: String?, code: String?) {
        if let _url = urlLogo {
            let url = URL(string: _url)
            imgLogo.sd_setImage(with: url, placeholderImage: nil)
        }
        if let _code = code {
            self.lbCodeNumber.text = _code
            imgBarcode.image = generateBarcode(from: _code)
        }
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
}
