//
//  ScanCodeViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import AVFoundation

protocol BarcodeDelegate: class {
    func barcodeReaded(barcode: String)
}

class ScanCodeViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbAddManual: UILabel!
    @IBOutlet weak var vScanCode: UIView!
    @IBAction func btnAddManuallyTapped() {
        let vcAddManual = AddManualViewController.configureViewController(merchant: viewModel.merchant.value)
        self.push(controller: vcAddManual, animated: true)
    }
    //-----
    weak var delegateBarCode: BarcodeDelegate?
    
    @IBAction func btnBackClick() {
        self.pop()
    }
    var viewModel = ScanCodeViewModel()
    let disposeBag = DisposeBag()
    //----
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var isReading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindData()
        captureSession = nil
        startReading()
    }
    
    class func configureController(merchant: Merchant?) -> UIViewController {
        let vcScanCode = ScanCodeViewController.initControllerFromNib() as! ScanCodeViewController
        vcScanCode.viewModel.merchant.value = merchant
        return vcScanCode
    }
    
    func setUpView() {
        lbAddManual.backgroundColor = PRColor.backgroundColor

    }
    
    func bindData() {
        viewModel.merchant.asObservable().subscribe(onNext: {[weak self] (merchant) in
            guard let strongSelf = self else { return }
            
            if let _logo = merchant?.logo, let _url = _logo.url, let _urlThumb = _url.thumb {
                let urlThumb = URL(string: _urlThumb)
                strongSelf.imgLogo.sd_setImage(with: urlThumb, placeholderImage: nil)
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigation()
        darkStatus()
    }
    
    func startReading() -> Bool {
        let captureDevice = AVCaptureDevice.default(for: .video)
        guard let _captureDevice = captureDevice else { return false}
        do {
            let input = try AVCaptureDeviceInput(device: _captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            // Do the rest of your work...
        } catch let error as NSError {
            // Handle any errors
            print(error)
            return false
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = vScanCode.layer.bounds
        vScanCode.layer.addSublayer(videoPreviewLayer)
        
        /* Check for metadata */
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        print(captureMetadataOutput.availableMetadataObjectTypes)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureSession?.startRunning()
        
        return true
    }
    
    @objc func stopReading() {
        captureSession?.stopRunning()
        captureSession = nil
        videoPreviewLayer.removeFromSuperlayer()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        for data in metadataObjects {
            let metaData = data as! AVMetadataObject
            print(metaData.description)
            let transformed = videoPreviewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                print(unwraped.stringValue)
                if let barcode = unwraped.stringValue {
                    self.delegateBarCode?.barcodeReaded(barcode: barcode)
                }
                lbAddManual.text = unwraped.stringValue
                lbAddManual.text = "Start"
                self.performSelector(onMainThread: #selector(stopReading), with: nil, waitUntilDone: false)
                isReading = false
            }
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        for data in metadataObjects {
//            let metaData = data as! AVMetadataObject
//            print(metaData.description)
//            let transformed = videoPreviewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
//            if let unwraped = transformed {
//                print(unwraped.stringValue)
//                if let barcode = unwraped.stringValue {
//                    self.delegateBarCode?.barcodeReaded(barcode: barcode)
//                    let vcAddManual = AddManualViewController.configureViewController(merchant: viewModel.merchant.value)
//                    self.push(controller: vcAddManual, animated: true)
//                }
//                self.performSelector(onMainThread: #selector(stopReading), with: nil, waitUntilDone: false)
//                isReading = false
//            }
//        }
        for metadata in metadataObjects {
            let readableObject = metadata as! AVMetadataMachineReadableCodeObject
            let code = readableObject.stringValue
        
            self.dismiss(animated: true, completion: nil)
            if let _code = code {
                print(_code)
                self.delegateBarCode?.barcodeReaded(barcode: _code)
                let vcAddManual = AddManualViewController.configureViewController(merchant: viewModel.merchant.value)
                self.push(controller: vcAddManual, animated: true)
            }
            
        }
    }

}
