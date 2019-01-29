//
//  Triangle.swift
//  Saper
//
//  Created by  Rezuan on 13/01/2019.
//  Copyright © 2019  Rezuan. All rights reserved.
//

import UIKit

class CellView : UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.backgroundColor = UIColor(red: 235, green: 235, blue: 235)
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX), y: rect.minY))
        context.closePath()
        context.setFillColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1)
        context.fillPath()
    
        guard let context1 = UIGraphicsGetCurrentContext() else { return }
        context1.beginPath()
        context1.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        context1.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context1.addLine(to: CGPoint(x: (rect.minX), y: rect.maxY))
        context1.closePath()
        
        
        context1.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
        context1.fillPath()
        

    }
    
    
}
