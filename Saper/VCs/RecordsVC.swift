//
//  RecordsVC.swift
//  Saper
//
//  Created by  Rezuan on 15/01/2019.
//  Copyright © 2019  Rezuan. All rights reserved.
//

import UIKit

class RecordsVC: UIViewController {

    let back = UIButton()

    var notes: [Note]?
    var maxCurRecord: Note?
    
    let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecords()
        
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
        
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    func loadRecords() {
        notes = DataManager.shared.fetchNotes()
        if let notes = notes, notes.count > 0 {
            var curRecord = notes[0]
            for note in notes {
                if note.time < curRecord.time {
                    curRecord = note
                }
            }
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

extension RecordsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let notes = notes {
            cell.textLabel?.text = "\(indexPath.row). \(String(describing: notes[indexPath.row].name)): \(TimeInterval(bitPattern: UInt64(notes[indexPath.row].time)).stringFormatted())"
        }
        return cell

    }
    
    
}
