//
//  ViewController.swift
//  Saper
//
//  Created by  Rezuan on 12/01/2019.
//  Copyright © 2019  Rezuan. All rights reserved.
//

import UIKit
import AVFoundation


enum Difficult {
    case easy
    case normal
}

class MainVC: UIViewController {
    
    //Timer
    var ssecs = 0
    var secs = 0
    var mins = 0
    var hours = 0
    var timeInterval = 0
    
    var timer = Timer()
    var timerIsStarted = false
    
    //Sound
    var sound: AVAudioPlayer?
    
    //View
    let header = UIView()
    let optionsMenu = UIButton()
    let hour = UILabel()
    let min = UILabel()
    let sec = UILabel()
    let ssec = UILabel()
    
    var cvLayot: UICollectionViewFlowLayout?
    var table: UICollectionView?
    
    //Game
    lazy var manager = Manager(rows: rows, columns: columns)
    var cellSize = 30
    var rows = 0
    var columns = 0
    var level: Difficult = .easy

    func userName() -> String {
        var text = ""
        let alert = UIAlertController(title: "Введите ваше имя", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ок", style: .default) { (_) in
            text = alert.textFields?.first?.text ?? ""
        }
        alert.addTextField(configurationHandler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
        return text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let height: CGFloat = 50
        
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: height).isActive = true
        header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        header.addSubview(optionsMenu)
        optionsMenu.translatesAutoresizingMaskIntoConstraints = false
        optionsMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        optionsMenu.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        optionsMenu.widthAnchor.constraint(equalToConstant: 50).isActive = true
        optionsMenu.heightAnchor.constraint(equalToConstant: height).isActive = true
        optionsMenu.setTitle("Меню", for: .normal)
        optionsMenu.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        optionsMenu.setTitleColor(.gray, for: .normal)
        
        header.addSubview(hour)
        hour.translatesAutoresizingMaskIntoConstraints = false
        hour.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        hour.leftAnchor.constraint(equalTo: optionsMenu.rightAnchor, constant: 50).isActive = true
        hour.heightAnchor.constraint(equalToConstant: height).isActive = true
        hour.widthAnchor.constraint(equalToConstant: height).isActive = true
        hour.text = "00"
        hour.textColor = .gray
        
        header.addSubview(min)
        min.translatesAutoresizingMaskIntoConstraints = false
        min.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        min.leftAnchor.constraint(equalTo: hour.rightAnchor, constant: 1).isActive = true
        min.heightAnchor.constraint(equalToConstant: height).isActive = true
        min.widthAnchor.constraint(equalToConstant: height).isActive = true
        min.text = "00"
        min.textColor = .gray
        
        header.addSubview(sec)
        sec.translatesAutoresizingMaskIntoConstraints = false
        sec.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        sec.leftAnchor.constraint(equalTo: min.rightAnchor, constant: 1).isActive = true
        sec.heightAnchor.constraint(equalToConstant: height).isActive = true
        sec.widthAnchor.constraint(equalToConstant: height).isActive = true
        sec.text = "00"
        sec.textColor = .gray
  
        header.addSubview(ssec)
        ssec.translatesAutoresizingMaskIntoConstraints = false
        ssec.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        ssec.leftAnchor.constraint(equalTo: sec.rightAnchor, constant: 1).isActive = true
        ssec.heightAnchor.constraint(equalToConstant: height).isActive = true
        ssec.widthAnchor.constraint(equalToConstant: height).isActive = true
        ssec.text = "00"
        ssec.textColor = .gray
        
        cellSize = 30
        columns = Int(UIScreen.main.bounds.width - 50) / 30
        rows = columns * 2
    
        initTable()
    
    }
    
    @objc func updateTimerText() {
        timeInterval += 1
        
        ssecs += 1
        if ssecs == 100 {
            secs += 1
            ssecs = 0
        }
        if secs == 60 {
            mins += 1
            secs = 0
        }
        if mins == 60 {
            hours += 1
            mins = 0
        }
        if hours == 60 {
            hours = 0
        }
        if ssecs < 10 {
            ssec.text = "0\(ssecs)"
        } else {
            ssec.text = "\(ssecs)"
        }
        if secs < 10 {
            sec.text = "0\(secs)"
        } else {
            sec.text = "\(secs)"
        }
        if mins < 10 {
            min.text = "0\(mins)"
        } else {
            min.text = "\(mins)"
        }
        if hours < 10 {
            hour.text = "0\(hours)"
        } else {
            hour.text = "\(hours)"
        }
    }
    
    func resetTimer() {
        ssecs = 0
        secs = 0
        mins = 0
        hours = 0
        timer.invalidate()
        timerIsStarted = false
    }
  
    
    @objc func openMenu() {
        callInfoMenu()
    }
    
    func callInfoMenu(text: String = "") {
        let info = MenuVC()
        info.isModalInPopover = true
        info.modalPresentationStyle = .overCurrentContext
        info.delegate = self
        info.infoText = text
        header.isHidden = true
        present(info, animated: true, completion: nil)
    }
    
    func playSound(name: String) {
        
        
        let path = Bundle.main.path(forResource: name, ofType: "mp3")!
        let url = NSURL(fileURLWithPath: path)
        
        do {
            
            sound = try! AVAudioPlayer(contentsOf: url as URL)
        
            sound?.volume = 1
            sound?.prepareToPlay()
            sound?.play()
            
        } catch {}
        
    }

    func initTable() {
        
        if level == .easy {
            cellSize = 60
        } else {
            cellSize = 30
        }
        columns = Int(UIScreen.main.bounds.width - 50) / cellSize
        rows = columns * 2 - 3
        cvLayot = UICollectionViewFlowLayout()
        if let cvLayot = cvLayot {
            cvLayot.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cvLayot.itemSize = CGSize(width: cellSize, height: cellSize)
            cvLayot.minimumLineSpacing = 1
            cvLayot.minimumInteritemSpacing = 1
        
            table = UICollectionView(frame: .zero, collectionViewLayout: cvLayot)
            if let table = table {
                manager = Manager(rows: rows, columns: columns)
                
                table.translatesAutoresizingMaskIntoConstraints = false
                table.backgroundColor = UIColor.gray
                view.addSubview(table)
                table.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
                table.widthAnchor.constraint(equalToConstant: CGFloat(cellSize * columns + columns - 1)).isActive = true
                table.heightAnchor.constraint(equalToConstant: CGFloat(cellSize * rows + rows - 1)).isActive = true
                table.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                
                table.dataSource = self
                table.delegate = self
                table.register(CellCV.self, forCellWithReuseIdentifier: CellCV.identifier)
                
            }
        }
    }
}



extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns * rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellCV = collectionView.dequeueReusableCell(withReuseIdentifier: CellCV.identifier, for: indexPath) as! CellCV
        
        let cell = manager.minesField[indexPath.row / columns][indexPath.row % columns]
        
        cellCV.setup(value: cell.value)

        if cell.isOpen == true {
            cellCV.frontGround.isHidden = true
    
        } else {
            cellCV.num.text = ""
            cellCV.frontGround.isHidden = false
        }
        
        
        return cellCV
    }
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if timerIsStarted == false {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimerText), userInfo: nil, repeats: true)
            timerIsStarted = true
        }
        
        let cell = manager.minesField[indexPath.row / columns][indexPath.row % columns]
        if !manager.isFinished {
            if cell.isOpen == false {
                if !manager.checkwin() {
                    manager.clean(i: indexPath.row / columns, j: indexPath.row % columns)
                    if manager.checkwin() {
                        playSound(name: "applause")
                        callInfoMenu(text: "Поздравляем!")
                        resetTimer()
                     
                    }
                } else {
                }
            }
            if cell.value == -1 {
                manager.openmines()
                playSound(name: "bomb")
                callInfoMenu(text: "БАБАХ!")
                resetTimer()
                manager.isFinished = true
            }
        } else {
            
        }
        
        collectionView.reloadData()
    }
}


extension MainVC: MenuDelegate {
  
    
    func close() {
        header.isHidden = false
    }
    
    func restart(level: Difficult) {
        self.level = level
        table?.removeFromSuperview()
        initTable()
        
        table?.reloadData()
    }
    
}
