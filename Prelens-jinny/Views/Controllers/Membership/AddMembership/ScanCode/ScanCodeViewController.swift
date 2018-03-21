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

class ScanCodeViewController: BaseViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbAddManual: UILabel!
    @IBAction func btnAddManuallyTapped() {
        let vcAddManual = AddManualViewController.initControllerFromNib() as! AddManualViewController
        viewModel.urlLogo.asObservable().bind(to: vcAddManual.viewModel.urlLogo).disposed(by: disposeBag)
        self.push(controller: vcAddManual, animated: true)
    }
    
    @IBAction func btnBackClick() {
        self.pop()
    }
    var viewModel = ScanCodeViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindData()
    }
    
    func setUpView() {
        lbAddManual.backgroundColor = PRColor.backgroundColor

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
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigation()
        darkStatus()
    }

}
