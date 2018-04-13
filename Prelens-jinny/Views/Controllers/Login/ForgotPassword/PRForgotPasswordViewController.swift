//
//  PRForgotPasswordViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/10/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PRForgotPasswordViewController: BaseViewController {
    @IBOutlet weak var vEmail: TextFieldView!
    @IBOutlet weak var btnSubmit: UIButton!

    let disposeBag = DisposeBag()
    var viewModel: ForgotPasswordViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkStatus()
        setupView()
        bindViewModel()
        hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupView() {
        vEmail.tfInput.placeholder = "Email"
        btnSubmit.layer.cornerRadius = 2.5
        super.setTitle(title: "FORGOT PASSWORD", textColor: .black, backgroundColor: .white)
        super.addBackButton()
    }
    class func configureViewController() -> PRForgotPasswordViewController {
        let forgotPasswordVC = PRForgotPasswordViewController.initControllerFromNib() as! PRForgotPasswordViewController
        var viewModel: ForgotPasswordViewModel {
            return ForgotPasswordViewModel()
        }
        forgotPasswordVC.viewModel = viewModel
        return forgotPasswordVC
    }
    
    func bindViewModel() {
        _ = vEmail.tfInput.rx.text.map { $0 ?? ""}.bind(to: viewModel.email)
        viewModel.email.asObservable().bind(to: vEmail.tfInput.rx.text).disposed(by: disposeBag)

        btnSubmit.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.btnSubmitTapped)
            .disposed(by: disposeBag)

        btnSubmit.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.vEmail.tfInput.endEditing(true)
            }).disposed(by: disposeBag)
        
        viewModel.isSuccess.subscribe (onCompleted: {
            DispatchQueue.main.async {
              self.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
}
