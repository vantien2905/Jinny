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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpScan()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        delay(0.5) {
            self.reloadScanner()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        scanner?.stopScan()
    }
    
    func setUpView() {
        setTitle(title: "ADD VOUCHER", textColor: .black, backgroundColor: .white)
        
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
            //            string in this colosure is the result
            print("abcabc")
        })
        scanner?.startScan()
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
