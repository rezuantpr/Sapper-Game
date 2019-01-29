//
//  CellCV.swift
//  Saper
//
//  Created by  Rezuan on 13/01/2019.
//  Copyright © 2019  Rezuan. All rights reserved.
//

import UIKit


class CellCV: UICollectionViewCell {
    
    
    static var identifier = "Cell"
    
    var view = UIView()
    let num = UILabel()
    
    let frontGround = CellView()
    let bombImageView = UIImageView()
    
    func setup(frame: CGRect = .zero, value: Int) {
        
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        if value == -1 {
            bombImageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(bombImageView)
            bombImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            bombImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            bombImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            bombImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            bombImageView.image = UIImage(named: "bomb")
        } else {
            addSubview(num)
            num.translatesAutoresizingMaskIntoConstraints = false
            num.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            num.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            num.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            num.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
            num.textAlignment = .center
            num.font = UIFont.boldSystemFont(ofSize: 20.0)
            num.text = ""
        }
        frontGround.translatesAutoresizingMaskIntoConstraints = false
        addSubview(frontGround)
        frontGround.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        frontGround.topAnchor.constraint(equalTo: topAnchor).isActive = true
        frontGround.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        frontGround.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        setTitle(value: value)
    }
    func setTitle(value: Int) {
        num.text = String(value)
        switch value {
        case -1:
            num.text = ""
        case 0:
            num.text = ""
        case 1:
            num.textColor = .blue
        case 2:
            num.textColor = .green
        case 3:
            num.textColor = .red
        case 4:
            num.textColor = UIColor.cyan
        case 5:
            num.textColor = .cyan
        default:
            break
        }
    }
    
}
