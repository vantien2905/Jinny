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
    @IBOutlet weak var vHeader: UIView!
    
    @IBAction func btnDoneTapped() {
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigation()
        darkStatus()
    }

    func setUpView() {
        vHeader.setShadow()
    }
    
    func bindData() {
        viewModel.urlLogo.asObservable().subscribe(onNext: {[weak self] (url) in
            guard let strongSelf = self else { return }
            if let _url = url, let _urlThumb = _url.thumb {
                let urlThumb = URL(string: _urlThumb)
                strongSelf.imgLogo.sd_setImage(with: urlThumb, placeholderImage: nil)
            }
        }).disposed(by: disposeBag)
    }
}
