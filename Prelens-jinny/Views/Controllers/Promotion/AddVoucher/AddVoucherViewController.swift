//
//  AddVoucherViewController.swift
//  Prelens-jinny
//
//  Created by Lamp on 23/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import PKHUD

class AddVoucherViewController: BaseViewController {
    
    @IBOutlet weak var vScanQR: UIView!
//    @IBOutlet weak var lcsVScanQRHeight: NSLayoutConstraint!
    @IBOutlet weak var btnRefreshScanner: UIButton!
    
    var viewModel: AddVoucherViewModelProtocol!
    let disposeBag = DisposeBag()
    
    var scanner: QRCode?
    var qrCode: String? {
        didSet {
            if let code = qrCode {
                viewModel.addVoucher(code: code)
                btnRefreshScanner.isHidden = false
            } else {
                btnRefreshScanner.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        viewModel = AddVoucherViewModel()
        btnRefreshScanner.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        delay(0.0) {
            self.reloadScanner()
        }
        setUpBinding()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        scanner?.stopScan()
        
    }
    
    func setUpBinding() {
        viewModel.resultString.asObservable().subscribe(onNext: { [weak self] result in
            guard let _result = result else { return }
            PopUpHelper.shared.showPopUp(message: _result, action: {
                self?.reloadScanner()
            })
        }).disposed(by: disposeBag)
    }
    
    func setUpView() {
        darkStatus()
        setTitle(title: "ADD VOUCHER", textColor: .black, backgroundColor: .white)
        addBackButton()
        self.navigationController?.navigationBar.isHidden = false
        setUpScan()
    }
    
    func setUpScan() {
        scanner?.removeAllLayers()
//        lcsVScanQRHeight.constant = UIScreen.main.bounds.width * (3/4)
        scanner?.setupLayers(vScanQR)
    }
    
    func reloadScanner() {
        scanner = QRCode()
        scanner?.maxDetectedCount = 1
        scanner?.prepareScan(vScanQR, completion: { (qrstring) in
            self.qrCode = qrstring
        })
        scanner?.startScan()
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    @IBAction func refreshScanner() {
        reloadScanner()
    }
}
