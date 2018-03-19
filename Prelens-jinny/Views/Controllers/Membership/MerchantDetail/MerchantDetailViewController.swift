//
//  MerchantDetailViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage

class MerchantDetailViewController: BaseViewController {

    @IBOutlet weak var tbMerchantDetail: UITableView!
    @IBOutlet weak var imgMerchant: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setUpNavigation()
    }

    func configureTableView() {
        tbMerchantDetail.register(UINib(nibName: Cell.merchantDetail, bundle: nil), forCellReuseIdentifier: Cell.merchantDetail)
        tbMerchantDetail.delegate = self
        tbMerchantDetail.dataSource = self
    }

    class func configureViewController() -> UIViewController {
        let vcMerchantDetail = MerchantDetailViewController.initControllerFromNib() as! MerchantDetailViewController

        return vcMerchantDetail
    }

    func setUpNavigation() {
        self.setTitle(title: "StarBucks", textColor: .black, backgroundColor: .white)
        addBackButton()
    }
}

extension MerchantDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.merchantDetail, for: indexPath) as! MerchantDetailCell

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }

}
