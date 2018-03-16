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

class PRForgotPasswordViewController: PRBaseViewController {
    @IBOutlet weak var tfEmail              : UITextField!
    @IBOutlet weak var btnSubmit            : UIButton!
    
    let disposeBag                          = DisposeBag()
    var vm                                  = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        //self.navigationController?.isNavigationBarHidden = false
        //self.navigationController?.navigationBar.barTintColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView(){
        btnSubmit.layer.cornerRadius = 2.5
        super.setTitle(title: "FORGOT PASSWORD", textColor: .black, backgroundColor: .white)
        super.addBackButton()
    }
 
    func bindViewModel() {
        _ = tfEmail.rx.text.map{ $0 ?? ""}.bind(to: vm.email)
        vm.email.asObservable().bind(to: tfEmail.rx.text).disposed(by: disposeBag)
        
        btnSubmit.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: vm.btnSubmitTapped)
            .disposed(by: disposeBag)
        
        btnSubmit.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.tfEmail.endEditing(true)
            }).disposed(by: disposeBag)
    }
}
