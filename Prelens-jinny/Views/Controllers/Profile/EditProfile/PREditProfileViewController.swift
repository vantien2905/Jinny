//
//  PRProfileViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/5/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import QuartzCore
import RxSwift
import RxCocoa

class PREditProfileViewController: BaseViewController {
   
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbResidentialRegion: UILabel!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var vResidentialRegion: UIView!
    @IBOutlet weak var vGender: UIView!
    @IBOutlet weak var vContainEmail: UIView!
    @IBOutlet weak var vContaintName: UIView!
    @IBOutlet weak var vContainDate: UIView!
    
    let viewModel = EditProfileViewModel()
    let disposeBag = DisposeBag()
    
    var user = PRUser(){
        didSet {
            self.updateLayout(user: user)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        darkStatus()
        
        addBackButton()
        viewModel.getProfile()
        bindData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindData() {
        viewModel.outputs.user.asObservable().subscribe(onNext: { user in
            if let _user = user {
                self.user = _user
            }
        }).disposed(by: disposeBag)
    }

    func updateLayout(user: PRUser){
        tfEmail.text    = user.email
        tfName.text     = user.fullName
        guard let _dob = user.dob else { return lbDate.text = " mm/yyyy" }
        lbDate.text     =  _dob
        guard let _gender = user.gender else { return lbGender.text = " Select"}
        lbGender.text   =  _gender
        guard let _residential = user.residentialRegion?.name else { return lbResidentialRegion.text = " Select" }
        lbResidentialRegion.text = _residential
    }
    
    func setupView(){
        tapHideKeyboard()
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: "Edit Profile", textColor: .black, backgroundColor: .white)
        
        
        vResidentialRegion.layer.borderWidth = 0.4
        vResidentialRegion.layer.borderColor = PRColor.borderColor.cgColor
        vResidentialRegion.layer.cornerRadius = 2.5
        
        vGender.layer.borderWidth = 0.4
        vGender.layer.borderColor = PRColor.borderColor.cgColor
        vGender.layer.cornerRadius = 2.5
        
        vContaintName.layer.borderWidth = 0.4
        vContaintName.layer.borderColor = PRColor.borderColor.cgColor
        vContaintName.layer.cornerRadius = 2.5
        
        vContainEmail.layer.borderWidth = 0.4
        vContainEmail.layer.borderColor = PRColor.borderColor.cgColor
        vContainEmail.layer.cornerRadius = 2.5
        btnSave.layer.cornerRadius = 2.5
        
        vContainDate.layer.borderWidth = 0.4
        vContainDate.layer.borderColor = PRColor.borderColor.cgColor
        vContainDate.layer.cornerRadius = 2.5
        btnSave.layer.cornerRadius = 2.5
        
    }
}
