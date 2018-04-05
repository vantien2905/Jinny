//
//  OverleyQRCode.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 4/5/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class OverlayQRCode: PRBaseView {
    
    var path = UIBezierPath()
    var lineWidth = CGFloat(10)
    var space = CGFloat(20)
    var lenghtLine = CGFloat(40)
    
    override func draw(_ rect: CGRect) {
        let width = self.frame.width
        let height = self.frame.height
        path.lineWidth = lineWidth
        path.move(to: CGPoint(x: space, y: space + lenghtLine))
        path.addLine(to: CGPoint(x: space, y: space))
        path.addLine(to: CGPoint(x: space + lenghtLine, y: space))
        
        path.move(to: CGPoint(x: width - space - lenghtLine, y: space))
        path.addLine(to: CGPoint(x: width - space, y: space))
        path.addLine(to: CGPoint(x: width - space, y: space + lenghtLine))
        
        path.move(to: CGPoint(x: width - space, y: height - space - lenghtLine))
        path.addLine(to: CGPoint(x: width - space, y: height - space))
        path.addLine(to: CGPoint(x: width - space - lenghtLine, y: height - space))
        
        path.move(to: CGPoint(x: space + lenghtLine, y: height - space))
        path.addLine(to: CGPoint(x: space, y: height - space))
        path.addLine(to: CGPoint(x: space, y: height - space - lenghtLine))
        
        UIColor.black.withAlphaComponent(0.5).setStroke()
        path.stroke()
        
    }
}
