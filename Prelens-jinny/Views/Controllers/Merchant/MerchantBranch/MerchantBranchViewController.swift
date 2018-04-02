//
//  MerchantBranchViewController.swift
//  Prelens-jinny
//
//  Created by Lamp on 21/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class MerchantBranchViewController: BaseViewController {
    
    @IBOutlet weak var tbMerchantBranch: UITableView!
    
    let daysArray = ["Monday", "Tuesday", "Webnesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var merchantBrancht = MerchantDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setUpView()
    }
    
    func configureTableView() {
        tbMerchantBranch.register(UINib(nibName: Cell.merchantDetailHeaderCell, bundle: nil), forCellReuseIdentifier: "headerCell")
        tbMerchantBranch.register(UINib(nibName: Cell.merchantBranchCell, bundle: nil), forCellReuseIdentifier: "merchantBranchCell")
        
        tbMerchantBranch.dataSource = self
        tbMerchantBranch.delegate = self
        
    }
    
    func setUpView() {
        self.setTitle(title: MembershipDetailViewController.merchantName!, textColor: .black, backgroundColor: .white)
        addBackButton()
        darkStatus()
    }
}

extension MerchantBranchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return daysArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tbMerchantBranch.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! MerchantDetailHeaderCell
            cell.imvMerchantAvatar.sd_setImage(with: MembershipDetailViewController.urlThumb!, placeholder: nil, failedImage: nil)
            cell.lbAddress.text = merchantBrancht.name
            cell.tvDescription.text = merchantBrancht.address
            cell.lcsImageAvatar.constant = 70
            return cell
        } else if indexPath.section == 2 {
            let cell = tbMerchantBranch.dequeueReusableCell(withIdentifier: "merchantBranchCell", for: indexPath) as! MerchantBranchCell
            cell.lbDays.text = daysArray[indexPath.row]
            if let startTime = merchantBrancht.openHours!.first?.startTime {
                if let closeTime = merchantBrancht.openHours!.first?.closeTime {
                    cell.lbTime.text = startTime + "-" + closeTime
                }
            }
            
            cell.lbOpeningHours.isHidden = true
            
            return cell
        } else {
            let cell = tbMerchantBranch.dequeueReusableCell(withIdentifier: "merchantBranchCell", for: indexPath) as! MerchantBranchCell
            cell.lbDays.isHidden = true
            cell.lbTime.isHidden = true
            cell.vBottomLine.isHidden = true
            cell.lbOpeningHours.text = "Opening hours"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            var cellHeight: CGFloat = 160
            if let description = merchantBrancht.address {
                let heightAdd = description.height(withConstrainedWidth: UIScreen.main.bounds.width - 70, font: UIFont.systemFont(ofSize: 14))
                cellHeight += heightAdd
            }
            if let name = merchantBrancht.name {
                 let heightName = name.height(withConstrainedWidth: UIScreen.main.bounds.width - 70, font: UIFont.systemFont(ofSize: 14))
                cellHeight += heightName
            }
            return cellHeight
        } else if indexPath.section == 1 {
            return 70
        } else {
            return 38
        }
    }
}
