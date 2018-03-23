//
//  PRHelper.swift
//  Prelens-jinny
//
//  Created by Lamp on 20/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class PRHelper {
    static func showVideo(fileUrl: URL) {
        let player = AVPlayer(url: fileUrl)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        guard let vc = UIApplication.topViewController() else { return }
        
        vc.present(playerVC, animated: true, completion: {
            playerVC.player?.play()
        })
    }
}

class ProgressLoadingHelper {
    
    static let shared = ProgressLoadingHelper()
    
    var vLoading = PRLoadingView()
    
    func showIndicator() {
        DispatchQueue.main.async {
            self.vLoading.showActivityIndicator()
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.vLoading.hideActivityIndicator()
        }
        
    }
}
