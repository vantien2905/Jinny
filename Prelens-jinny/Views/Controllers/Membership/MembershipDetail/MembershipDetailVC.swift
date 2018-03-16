//
//  MembershipDetailVC.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift

class MembershipDetailVC: PRBaseViewController {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var imgBarCode: UIImageView!
    @IBOutlet weak var lbNumberCode: UILabel!
    @IBOutlet weak var imgRelated: UIImageView!
    let disposeBag = DisposeBag()
    let viewModel = MembershipDetailViewModel()
    
    var membershipDetail = Member() {
        didSet {
            self.setData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        bindData()
        setData()
    }
    
    class func configureViewController(id: Int?) -> UIViewController {
        let vc = MembershipDetailVC.initControllerFromNib() as! MembershipDetailVC
        if let _id = id {
            vc.viewModel.inputs.idMembership.value = _id
        }
        return vc
    }
    
    func setNavigation() {
        setTitle(title: "STARBUCKS", textColor: UIColor.black, backgroundColor: .white)
        addBackButton()
        addStarButton()
    }
    
    func bindData() {
        viewModel.outputs.membership.asObservable().subscribe(onNext: { (member) in
            if let _member = member {
                self.membershipDetail = _member
            }
            
        }).disposed(by: disposeBag)
    }
    
    func setData() {
        if let _merchant = membershipDetail.merchant, let _name = _merchant.name {
            setTitle(title: _name, textColor: UIColor.black, backgroundColor: .white)
        }
        
        if let _code = membershipDetail.code {
            lbNumberCode.text = _code
        }
    }

}
