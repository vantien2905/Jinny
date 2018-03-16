//
//  MembershipDetailVC.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class MembershipDetailVC: BaseViewController {
    
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
    
    var isStarTapped = false

    override func viewDidLoad() {
        super.viewDidLoad()
        imgLogo.contentMode = .scaleAspectFill
        imgBarCode.contentMode = .scaleAspectFill
        imgRelated.contentMode = .scaleAspectFill
        imgBarCode.layer.masksToBounds = true
        imgRelated.layer.masksToBounds = true
        imgLogo.layer.masksToBounds = true
        setNavigation()
        bindData()
        setData()
        self.delegate = self
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
        addStarButtonOn()
    }
    
    func bindData() {
        viewModel.outputs.membership.asObservable().subscribe(onNext: { (member) in
            if let _member = member {
                self.membershipDetail = _member
            }
            
        }).disposed(by: disposeBag)
    }
    
    func setData() {
        
        if let _merchant = membershipDetail.merchant {
            if let  _name = _merchant.name {
                setTitle(title: _name, textColor: UIColor.black, backgroundColor: .white)
            }
            if let _logo = _merchant.logo, let _url = _logo.url {
                if let _urlLogo = _url.thumb {
                    let url = URL(string: _urlLogo)
                    imgLogo.sd_setImage(with: url, placeholderImage: nil)
                }
                if let _urlMedium = _url.medium {
                    let url = URL(string: _urlMedium)
                    imgBarCode.sd_setImage(with: url, placeholderImage: nil)
                }
                if let _urlOrigin = _url.original {
                    let url = URL(string: _urlOrigin)
                    imgRelated.sd_setImage(with: url, placeholderImage: nil)
                }
            }
        }
        
        membershipDetail.hasBookmark == true ? addStarButtonOn() : addStarButtonOff()
        isStarTapped = membershipDetail.hasBookmark
        
        if let _code = membershipDetail.code {
            lbNumberCode.text = _code
        }
    }
}

extension MembershipDetailVC: BaseViewControllerDelegate {
    func starBookmarkTapped() {
        isStarTapped = !isStarTapped
        isStarTapped ? addStarButtonOn() : addStarButtonOff()
        viewModel.inputs.isBookmark.value = true
    }
}
