//
//  PopUpView.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/13/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

typealias CompletionClosure = (() -> Void)
class BasePopUpView: UIView {
    let vBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()

    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    lazy var btnCover: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(btnCoverTapped), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        addSubview(vBackground)
        vBackground.fillSuperview()
        vBackground.addSubview(btnCover)
        btnCover.fillSuperview()
        vBackground.addSubview(vContent)
    }

    @objc func btnCoverTapped() {
//        hidePopUp()
    }

    func showPopUp(height: CGFloat = 250) {
        if let window = UIApplication.shared.keyWindow {
            vContent.frame = CGRect(x: 0, y: window.frame.height + height, width: window.frame.width, height: height)

            window.addSubview(self)
            self.fillSuperview()
            self.vBackground.alpha = 0
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: { [unowned self] in
                self.vBackground.alpha = 1
                if #available(iOS 11, *) {
                    self.vContent.frame = CGRect(x: 0, y: window.safeAreaLayoutGuide.layoutFrame.height - height, width: window.safeAreaLayoutGuide.layoutFrame.width, height: height)
                } else {
                    self.vContent.frame = CGRect(x: 0, y: window.frame.height - height, width: window.frame.width, height: height)
                }
                }, completion: nil)
        }
    }

    func hidePopUp(success: ((Bool) -> Void)? = nil) {
        self.vBackground.alpha = 1
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.vContent.frame = CGRect(x: 0, y: window.frame.height + 1000, width: self.vContent.frame.width, height: self.vContent.frame.height)

            }, completion: { [weak self] _ in
                guard let strongSelf = self else {
                    success?(false)
                    return }

                strongSelf.vBackground.alpha = 0
                strongSelf.removeFromSuperview()
                success?(true)
        })

    }
}
