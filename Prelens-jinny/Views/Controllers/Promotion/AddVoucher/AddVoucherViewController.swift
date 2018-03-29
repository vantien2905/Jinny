//
//  AddVoucherViewController.swift
//  Prelens-jinny
//
//  Created by Lamp on 23/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import PKHUD

class AddVoucherViewController: BaseViewController {
    
    @IBOutlet weak var vScanQR: UIView!
    @IBOutlet weak var lcsVScanQRHeight: NSLayoutConstraint!
    
    var scanner: QRCode?
    var qrCode: String? {
        didSet{
            guard let code = qrCode else { return }
            PopUpHelper.shared.showPopUp(message: code) {
                self.reloadScanner()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        delay(1) {
            self.reloadScanner()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        scanner?.stopScan()
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
        lcsVScanQRHeight.constant = UIScreen.main.bounds.width * (3/4)
        scanner?.setupLayers(vScanQR)
    }
    
    func reloadScanner() {
        scanner = QRCode()
        scanner?.maxDetectedCount = 1
        scanner?.prepareScan(vScanQR, completion: { (qrstring) in
            self.qrCode = qrstring
            print(qrstring)
        })
        scanner?.startScan()
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
