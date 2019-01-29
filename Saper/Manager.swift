//
//  Logiс.swift
//  Saper
//
//  Created by  Rezuan on 12/01/2019.
//  Copyright © 2019  Rezuan. All rights reserved.
//

import Foundation

struct Cell {
    var value: Int
    var isOpen: Bool
    
    init(value: Int, isOpen: Bool) {
        self.value = value
        self.isOpen = isOpen
        self.isOpen = false
    }
}

class Manager {
    let rows: Int
    let columns: Int
    
    var minesField: [[Cell]]
    
    var isFinished = false

    
    init(rows: Int, columns: Int) {
        minesField = Array(repeating:
            Array(repeating:
                Cell(value: 0, isOpen: false),
                count: columns),
            count: rows)
    
        let minesCount = (rows + columns)/2
        var i: Int
        var j: Int
        for _ in 0..<minesCount {
            repeat {
                i = Int.random(in: 0..<rows)
                j = Int.random(in: 0..<columns)
            } while minesField[i][j].value == -1
            
            minesField[i][j].value = -1
        }
        
        
        self.rows = rows
        self.columns = columns
        
        self.setValues()
        
       
    }
    
    
    func mine(i: Int, j: Int) -> Bool {
        if i >= 0 && i < rows && j >= 0 && j < columns {
            if minesField[i][j].value == -1 {
                return true
            }
        }
        return false
    }
    
    func empty(i: Int, j: Int) -> Bool {
        if i >= 0 && i < columns && j >= 0 && j < rows {
            if minesField[i][j].value == 0 {
                return true
            }
        }
        return false;
    }
    
    func setValues() {
        
        for i in 0..<rows {
            for j in 0..<columns {
                if minesField[i][j].value != -1 {
                   
                    var count = 0
                    
                    for m in i - 1...i + 1 {
                        for n in j - 1...j + 1 {
                            
                            if mine(i: m, j: n) {
                                count += 1
                            }
                        }
                    }
                    minesField[i][j].value = count
                }
            }
        }
    }
    
    
    func clean(i: Int, j: Int){
    // проверим на выход за пределы массива
        if i >= 0 && i < rows && j >= 0 && j < columns {
            // проверим, не было ли открыто поле раньше
            if minesField[i][j].isOpen == false {
            // откроем
                minesField[i][j].isOpen = true
                
                // если поле пустое (=0), просто пооткрываем всех его соседей
                if minesField[i][j].value == 0 {
                    clean(i: i - 1, j: j - 1)
                    clean(i: i - 1, j: j)
                    clean(i: i - 1, j: j + 1)
                    clean(i: i, j: j - 1)
                    clean(i: i, j: j + 1)
                    clean(i: i + 1, j: j - 1)
                    clean(i: i + 1, j: j)
                    clean(i: i + 1, j: j + 1)
        
                }
    
            }
            
        }
    }

    func openmines() {
        for i in 0..<rows {
            for j in 0..<columns {
                if minesField[i][j].value == -1 {
                    minesField[i][j].isOpen = true
                }
            }
        }
    }
    
    func checkwin() -> Bool {
        for i in 0..<rows {
            for j in 0..<columns {
                if minesField[i][j].value != -1 && !minesField[i][j].isOpen {
                    return false
                }
            }
        }
        
        return true
    }
}
