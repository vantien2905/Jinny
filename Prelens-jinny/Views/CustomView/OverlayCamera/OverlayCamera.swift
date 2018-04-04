//
//  OverlayCamera.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 4/4/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class OverlayCamera: PRBaseView {
    
    var path = UIBezierPath()
    var pathLine = UIBezierPath()
    var lineWidth = CGFloat(20)

    override func draw(_ rect: CGRect) {
        path.lineWidth = lineWidth
        path.move(to: CGPoint(x: lineWidth/2, y: lineWidth/2))
        path.addLine(to: CGPoint(x: self.frame.width - lineWidth/2, y: lineWidth/2))
        path.addLine(to: CGPoint(x: self.frame.width - lineWidth/2, y: self.frame.height - lineWidth/2))
        path.addLine(to: CGPoint(x: lineWidth/2, y: self.frame.height - lineWidth/2))
        path.close()
        path.stroke(with: .color, alpha: 0.3)
        
        pathLine.lineWidth = 1
        pathLine.move(to: CGPoint(x: lineWidth, y: self.frame.height/2))
        pathLine.addLine(to: CGPoint(x: self.frame.width - lineWidth, y: self.frame.height/2))
        UIColor.red.setStroke()
        pathLine.stroke()
        
    }
}
