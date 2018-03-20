//
//  UIViewController+extension.swift
//  Prelens-jinny
//
//  Created by vinova on 3/6/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

public extension UIViewController {
    class func initControllerFromNib() -> UIViewController {
        let isNib: Bool = Bundle.main.path(forResource: self.className, ofType: "nib") != nil
        guard isNib else {
            assert(!isNib, "invalid nib file")
            return UIViewController()
        }

        return self.init(nibName: self.className, bundle: nil)
    }
    
    class var identifier: String {
        return "\(self)"
    }
    
    static func instantiateFromNib() -> Self {
        return self.init(nibName: (self as UIViewController.Type).identifier, bundle: nil)
    }
    
}
extension UIViewController {
    func getViewController<T: UIViewController>(controller: T) -> T {
        let nibName = String(describing: type(of: self))
        return  T(nibName: nibName, bundle: Bundle.main)
    }

    private func removeController(controller: UIViewController) {
        controller.willMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }

    func moveController(controller: UIViewController, vContent: UIView, fromRight: Bool = true) {
        let beginX = fromRight ? -vContent.frame.width:  2*vContent.frame.width

        UIView.animate(withDuration: 0.3, animations: {
            controller.view.frame = CGRect(x: beginX, y: 0, width: vContent.frame.width, height: vContent.frame.height)
        }) {_ in
            self.removeController(controller: controller)
        }
    }

    /**
     inset have animation from left or right
     */
    func insertController(controller: UIViewController, vContent: UIView, fromRight: Bool = true) {

        let beginX = fromRight ? vContent.frame.width: -vContent.frame.width

        //---
        let frameBegin = CGRect(x: beginX, y: 0, width: vContent.frame.width, height: vContent.frame.height)
        self.addChildViewController(controller)
        controller.view.frame = frameBegin
        vContent.addSubview(controller.view)
        controller.didMove(toParentViewController: self)

        UIView.animate(withDuration: 0.3, animations: {
            controller.view.frame = CGRect(x: vContent.frame.minX, y: 0, width: vContent.frame.width, height: vContent.frame.height)
        })
    }
}

extension UIViewController {
    func push(controller: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }

    func present(controller: UIViewController, animated: Bool = true) {
        self.present(controller, animated: animated, completion: nil)
    }

    func pop(animated: Bool = true ) {
        self.navigationController?.popViewController(animated: animated)
    }

}

extension UIViewController {
    func tapHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissEditing))

        view.addGestureRecognizer(tap)
    }

    @objc func dismissEditing() {
        view.endEditing(true)
    }
}
