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
    @IBOutlet weak var cvPromotion: UICollectionView!
    
    @IBAction func btnLogoTapped() {
        
    }
    
    let disposeBag = DisposeBag()
    
    var viewModel: MembershipDetailViewModelProtocol!
    
    var membershipDetail = Member() {
        didSet {
            self.setData()
        }
    }
    
    var listPromotion: Variable<[UIImage]> = Variable<[UIImage]>( [PRImage.imgStarOn, PRImage.imgStarOn, PRImage.imgStarOn, PRImage.imgStarOn, PRImage.imgStarOn])
    
    var isStarTapped = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgLogo.contentMode = .scaleAspectFill
        imgBarCode.contentMode = .scaleAspectFill
        imgBarCode.layer.masksToBounds = true
        imgLogo.layer.masksToBounds = true
        
        configureCollectionView()
        setNavigation()
        bindData()
        setData()
        self.delegate = self
    }
    
    func configureCollectionView() {
        cvPromotion.register(UINib(nibName: Cell.membershipDetail, bundle: nil), forCellWithReuseIdentifier: Cell.membershipDetail)
        cvPromotion.isPagingEnabled = true
        
        if let layout = self.cvPromotion.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
        }
        
        cvPromotion.delegate = self
        cvPromotion.dataSource = self
    }
    
    class func configureViewController(id: Int) -> UIViewController {
        let vc = MembershipDetailVC.initControllerFromNib() as! MembershipDetailVC

        var viewModel: MembershipDetailViewModelProtocol {
            return MembershipDetailViewModel(idMember: id)
        }
        vc.viewModel = viewModel
        return vc
    }
    
    func setNavigation() {
        setTitle(title: "STARBUCKS", textColor: UIColor.black, backgroundColor: .white)
        addBackButton()
        addStarButtonOn()
    }
    
    func bindData() {
        
        viewModel.membership.asObservable().subscribe(onNext: { (member) in
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
//                if let _urlMedium = _url.medium {
//                    let url = URL(string: _urlMedium)
//                    imgBarCode.sd_setImage(with: url, placeholderImage: nil)
//                }
            }
        }
        
        membershipDetail.hasBookmark == true ? addStarButtonOn() : addStarButtonOff()
        isStarTapped = membershipDetail.hasBookmark
        
        if let _code = membershipDetail.code {
            lbNumberCode.text = _code
            imgBarCode.image = generateBarcode(from: "8934602001078")
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

extension MembershipDetailVC: BaseViewControllerDelegate {
    func starBookmarkTapped() {
        isStarTapped = !isStarTapped
        isStarTapped ? addStarButtonOn() : addStarButtonOff()
//        viewModel.inputs.isBookmark.value = true
    }
}

extension MembershipDetailVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.membershipDetail, for: indexPath) as! MembershipDetailCell
        cell.imgPromotion.image = listPromotion.value[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
