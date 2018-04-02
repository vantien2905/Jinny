//
//  PRProfileViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/5/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
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
    @IBOutlet weak var btnSelectGender: UIButton!
    @IBOutlet weak var btnSelectRegion: UIButton!
    @IBOutlet weak var btnChooseDate: UIButton!
    
    let viewModel = EditProfileViewModel()
    let disposeBag = DisposeBag()
    
    var listRegion = [ResidentialRegion]()
    var listGender = ["male", "female"]
    var selectGender: Bool = false
    
    var user = PRUser() {
        didSet {
            self.updateLayout(user: user)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        darkStatus()
        addBackButton()
        viewModel.getProfile()
        viewModel.getResidentialRegion()
        bindData()
    }
    
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
    
    func bindData() {
        viewModel.user.asObservable().subscribe(onNext: { user in
            if let _user = user {
                self.user = _user
            }
        }).disposed(by: disposeBag)
        
        viewModel.regions.asObservable().subscribe(onNext: { list in
            self.listRegion = list
        }).disposed(by: disposeBag)
    }

    func updateLayout(user: PRUser) {
        tfEmail.text            = user.email
        viewModel.email.value   = tfEmail.text
        tfName.text             = user.fullName
        viewModel.name.value    = tfName.text
        
        guard let _dob = user.dob else { return lbDate.text = " mm/yyyy" }
        viewModel.dob.value     = _dob
        lbDate.text             =  _dob
        
        if let _residential = user.residentialRegion?.name {
            viewModel.regionID.value = user.residentialRegion?.id
            lbResidentialRegion.text = _residential
        } else {
            lbResidentialRegion.text = " Select"
        }
        
        if let _gender = user.gender {
            viewModel.gender.value = _gender
            lbGender.text   =  _gender
        } else {
            lbGender.text = " Select"
        }
    }
    
    func bindViewModel() {
         _ = tfEmail.rx.text.map { $0?.cutWhiteSpace() ?? ""}.bind(to: viewModel.email).disposed(by: disposeBag)
        _ = tfName.rx.text.map { $0?.cutWhiteSpace() ?? ""}.bind(to: viewModel.name).disposed(by: disposeBag)
       
        
        btnSave.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.btnSaveTapped)
            .disposed(by: disposeBag)
        
        btnSave.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.tfEmail.endEditing(true)
               self.tfName.endEditing(true)
            }).disposed(by: disposeBag)
        
        btnSelectGender.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.selectGender = true
                let choose = SelectDataPopUpView()
                choose.delegate = self
                //self.vmNewTask.inputs.isStartDate.value = false
                self.tfName.endEditing(true)
                self.tfEmail.endEditing(true)
               choose.showPopUp()
            }).disposed(by: disposeBag)
        
        btnChooseDate.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                let choose = ChooseDatePopupView()
                choose.delegate = self
                //self.vmNewTask.inputs.isStartDate.value = false
                self.tfName.endEditing(true)
                self.tfEmail.endEditing(true)
                choose.showPopUp(minDate: nil, maxDate: Date(), currentDate: nil)
            }).disposed(by: disposeBag)
    
        btnSelectRegion.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.selectGender = false
                let choose = SelectDataPopUpView()
                choose.delegate = self
                //self.vmNewTask.inputs.isStartDate.value = false
                self.tfName.endEditing(true)
                self.tfEmail.endEditing(true)
                choose.showPopUp()
            }).disposed(by: disposeBag)
        
        viewModel.isUpdateSuccess.subscribe (onCompleted: {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    func setupView() {
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
extension PREditProfileViewController:SelectDataPopUpViewDelegate {
    
    func numberOfRows() -> Int {
        switch selectGender {
        case true:
            return listGender.count
        default:
            return listRegion.count
        }
    }
    
    func titleForRow(index:Int) -> String {
        guard let title = listRegion[index].name else { return ""}
        switch selectGender {
        case true:
            return listGender[index]
        default:
            return title
        }
    }
    func didSelectRow(index:Int) {
        switch selectGender {
        case true:
            lbGender.text = listGender[index]
            viewModel.gender.value =  listGender[index]
        default:
            lbResidentialRegion.text = listRegion[index].name
            viewModel.regionID.value = listRegion[index].id ?? 0
        }
    }
}
extension PREditProfileViewController: ChooseDatePopUpViewDelegate {
    
    func selectedDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let _date = dateFormatter.string(from: date)
        lbDate.text = _date
        viewModel.dob.value = lbDate.text
        //vmNewTask.inputs.dateSelected.value = date
    }
}