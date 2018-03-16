//
//  PRChangePassWordViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/8/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PRChangePassWordViewController: BaseViewController {

    @IBOutlet weak var tfCurrentPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var btnChange: UIButton!
    
    var viewModel: ChangePasswordViewModel = ChangePasswordViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView(){
        tfNewPassword.isSecureTextEntry = true
        tfCurrentPassword.isSecureTextEntry = true
        btnChange.layer.cornerRadius = 2.5
        super.setTitle(title: "CHANGE PASSWORD", textColor: .black, backgroundColor: .white)
        super.addBackButton()
    }
    
    func bindViewModel() {
        _ = tfCurrentPassword.rx.text.map{ $0 ?? ""}.bind(to: viewModel.currentPassword)
        _ = tfNewPassword.rx.text.map{ $0 ?? ""}.bind(to: viewModel.newPassword)
        
        viewModel.currentPassword.asObservable().bind(to: tfCurrentPassword.rx.text).disposed(by: disposeBag)
        viewModel.newPassword.asObservable().bind(to: tfNewPassword.rx.text).disposed(by: disposeBag)
        
        btnChange.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.btnChangeTapped)
            .disposed(by: disposeBag)
        
        btnChange.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.tfCurrentPassword.endEditing(true)
                self.tfNewPassword.endEditing(true)
            }).disposed(by: disposeBag)
    }
}
