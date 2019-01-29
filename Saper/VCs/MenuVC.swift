//
//  ManagerVC.swift
//  Saper
//
//  Created by  Rezuan on 13/01/2019.
//  Copyright © 2019  Rezuan. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    let back = UIButton()
    
    let text = UILabel()
    
    var infoText: String? {
        didSet {
            text.text = infoText
        }
    }
    
    let newGameLbl = UILabel()
    
    let newGame1 = UIButton()
    let newGame2 = UIButton()
    let records = UIButton()
    
    var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .none
        view.isOpaque = false
        
        view.addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        back.widthAnchor.constraint(equalToConstant: 70).isActive = true
        back.heightAnchor.constraint(equalToConstant: 50).isActive = true
        back.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        back.setTitle("Назад", for: .normal)
        back.addTarget(self, action: #selector(close), for: .touchUpInside)
        back.setTitleColor(.gray, for: .normal)
        
        view.addSubview(records)
        records.translatesAutoresizingMaskIntoConstraints = false
        records.widthAnchor.constraint(equalToConstant: 200).isActive = true
        records.heightAnchor.constraint(equalToConstant: 50).isActive = true
        records.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -2).isActive = true
        records.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        records.setTitle("Настройки", for: .normal)
        records.setTitleColor(.white, for: .normal)
        records.backgroundColor = .gray
        
        view.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        text.heightAnchor.constraint(equalToConstant: 50).isActive = true
        text.bottomAnchor.constraint(equalTo: records.topAnchor, constant: -10).isActive = true
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.font = UIFont.boldSystemFont(ofSize: 40.0)
        text.textAlignment = .center
        text.textColor = UIColor.init(rgb: 0x2C2C2C)
        
        view.addSubview(newGameLbl)
        newGameLbl.translatesAutoresizingMaskIntoConstraints = false
        newGameLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        newGameLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newGameLbl.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 2).isActive = true
        newGameLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGameLbl.text = "Новая игра"
        newGameLbl.font = UIFont.boldSystemFont(ofSize: 24.0)
        newGameLbl.textAlignment = .center
        newGameLbl.textColor = UIColor.init(rgb: 0x2C2C2C)
        
        view.addSubview(newGame1)
        newGame1.translatesAutoresizingMaskIntoConstraints = false
        newGame1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        newGame1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newGame1.topAnchor.constraint(equalTo: newGameLbl.bottomAnchor, constant: 5).isActive = true
        newGame1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGame1.setTitle("Лёгкий", for: .normal)
        newGame1.setTitleColor(.white, for: .normal)
        newGame1.backgroundColor = .gray
        newGame1.addTarget(self, action: #selector(restart1), for: .touchUpInside)
        
        view.addSubview(newGame2)
        newGame2.translatesAutoresizingMaskIntoConstraints = false
        newGame2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        newGame2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newGame2.topAnchor.constraint(equalTo: newGame1.bottomAnchor, constant: 10).isActive = true
        newGame2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGame2.setTitle("Средний", for: .normal)
        newGame2.setTitleColor(.white, for: .normal)
        newGame2.backgroundColor = .gray
        newGame2.addTarget(self, action: #selector(restart2), for: .touchUpInside)
    }
    @objc func showRecords() {
        let recordsVC = RecordsVC()
        present(recordsVC, animated: true, completion: nil)
    }
    
    @objc func restart1() {
        delegate?.close()
        delegate?.restart(level: .easy)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func restart2() {
        delegate?.close()
        delegate?.restart(level: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func close() {
        delegate?.close()
        dismiss(animated: true, completion: nil)
    }
}

