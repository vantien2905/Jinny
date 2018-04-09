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
    var lineWidth = CGFloat(6)
    var space = CGFloat(3)
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
        
        path.move(to: CGPoint(x: lenghtLine/2 + 15, y: height/2))
        path.addLine(to: CGPoint(x: width - lenghtLine/2 - 15, y: height/2))
        
        UIColor.white.setStroke()
        path.stroke()
    }
}
