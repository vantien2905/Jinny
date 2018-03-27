//
//  AddManualViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift

class AddManualViewController: BaseViewController {

    @IBOutlet weak var tfSerial: UITextField!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var vHeader: UIView!
    @IBOutlet weak var vTextField: UIView!
    var serial: String?
    @IBAction func btnDoneTapped() {
        if let _code = tfSerial.text, let _merchant = viewModel.merchant.value {
            viewModel.addMembership(code: _code, merchantId: _merchant.id)
        }
    }
    
    @IBAction func btnBackClick() {
        self.pop()
    }
    
    let viewModel = AddManualViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindData()
        hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigation()
        darkStatus()
    }

    func setUpView() {
        vHeader.setShadow()
        tfSerial.attributedPlaceholder = "Serial number".toAttributedString(color: PRColor.searchColor.withAlphaComponent(0.5), font: PRFont.semiBold15, isUnderLine: false)
        vTextField.layer.cornerRadius = 2.5
        vTextField.layer.borderWidth = 1
        vTextField.layer.borderColor = PRColor.lineColor.cgColor
        btnDone.layer.cornerRadius = 2.5
        tfSerial.text = serial
    }
    
    class func configureViewController(merchant: Merchant?) -> UIViewController {
        let vcManual = AddManualViewController.initControllerFromNib() as! AddManualViewController
        vcManual.viewModel.merchant.value = merchant
        return vcManual
    }
    
    func bindData() {

        viewModel.isAddSuccess.asObservable().subscribe(onNext: {[weak self] (isSuccess) in
            if isSuccess == true {
                PopUpHelper.shared.showPopUp(message: "Membership added", action: {
                    guard let strongSelf = self else { return }
                    if isSuccess == true {
                        let viewControllers: [UIViewController] = strongSelf.navigationController!.viewControllers as [UIViewController]
                        strongSelf.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                    }
                })
            }
        }).disposed(by: disposeBag)
        
        viewModel.merchant.asObservable().subscribe(onNext: {[weak self] (merchant) in
            guard let strongSelf = self else { return }
            
            if let _logo = merchant?.logo, let _url = _logo.url, let _urlThumb = _url.thumb {
                let urlThumb = URL(string: _urlThumb)
                strongSelf.imgLogo.sd_setImage(with: urlThumb, placeholderImage: nil)
            }
        }).disposed(by: disposeBag)
    }
}

//extension AddManualViewController: BarcodeDelegate {
//    func barcodeReaded(barcode: String) {
//        tfSerial.text = barcode
//    }
//    
//    
//}

