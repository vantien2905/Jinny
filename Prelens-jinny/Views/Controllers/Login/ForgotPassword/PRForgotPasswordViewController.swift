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

    let disposeBag                          = DisposeBag()
    var vm                                  = ForgotPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        darkStatus()
        setupView()
        bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupView() {
        tapHideKeyboard()
        vEmail.tfInput.placeholder = "Email"
        btnSubmit.layer.cornerRadius = 2.5
        super.setTitle(title: "FORGOT PASSWORD", textColor: .black, backgroundColor: .white)
        super.addBackButton()
    }

    func bindViewModel() {
        _ = vEmail.tfInput.rx.text.map { $0 ?? ""}.bind(to: vm.email)
        vm.email.asObservable().bind(to: vEmail.tfInput.rx.text).disposed(by: disposeBag)

        btnSubmit.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: vm.btnSubmitTapped)
            .disposed(by: disposeBag)

        btnSubmit.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.vEmail.tfInput.endEditing(true)
            }).disposed(by: disposeBag)
        
        vm.isSuccess.subscribe (onCompleted: {
            DispatchQueue.main.async {
              self.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
}
