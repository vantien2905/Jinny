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

class ScanCodeViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbAddManual: UILabel!
    @IBOutlet weak var vScanCode: UIView!
   
    var viewModel = ScanCodeViewModel()
    let disposeBag = DisposeBag()
    //----
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var isReading: Bool = false
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindData()
        captureSession = nil
        startReading()
    }
    
    // MARK: Action
    @IBAction func btnAddManuallyTapped() {
        let vcAddManual = AddManualViewController.configureViewController(merchant: viewModel.merchant.value)
        self.push(controller: vcAddManual, animated: true)
    }
    
    @IBAction func btnBackClick() {
        self.pop()
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
        viewModel.isAddSuccess.asObservable().subscribe(onNext: {[weak self] (isSuccess) in
            if isSuccess == true {
                PopUpHelper.shared.showPopUp(message: "Membership added", action: {
                    guard let strongSelf = self else { return }
                    if isSuccess == true {
                        if let id = strongSelf.viewModel.membership.value?.id {
                            let vcMembershipDetail = MembershipDetailViewController.configureViewController(idMembership: id)
                            strongSelf.push(controller: vcMembershipDetail, animated: true)
                        }
                    }
                })
            }
        }).disposed(by: disposeBag)
        
        viewModel.isAddFail.asObservable().subscribe(onNext: {[weak self] (fail) in
            guard let strongSelf = self else { return }
            if fail == true {
                strongSelf.videoPreviewLayer.removeFromSuperlayer()
                strongSelf.startReading()
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
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigation()
        darkStatus()
    }
    
    func startReading() {

        let captureDevice = AVCaptureDevice.default(for: .video)
        guard let _captureDevice = captureDevice else { return}
        do {
            let input = try AVCaptureDeviceInput(device: _captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            // Do the rest of your work...
            
        } catch let error as NSError {
            // Handle any errors
            print(error)
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        print(vScanCode.layer.bounds)
        videoPreviewLayer.frame = CGRect(x: vScanCode.layer.bounds.minX,
                                         y: vScanCode.layer.bounds.minY,
                                         width: UIScreen.main.bounds.size.width,
                                         height: 250)
        vScanCode.layer.addSublayer(videoPreviewLayer)
        
        /* Check for metadata */
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
//        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
        print(captureMetadataOutput.availableMetadataObjectTypes)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureSession?.startRunning()
        
        return
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        for metadata in metadataObjects {
            let readableObject = metadata as? AVMetadataMachineReadableCodeObject
            guard let _readableObject = readableObject else { return }
            let code = _readableObject.stringValue
            self.dismiss(animated: true, completion: nil)
            
            if let _code = code {
                print(_code)
                 captureSession?.stopRunning()
                if let _merchant = viewModel.merchant.value {
                    viewModel.addMembership(code: _code, merchantId: _merchant.id)
                }
            }
        }
    }
}
