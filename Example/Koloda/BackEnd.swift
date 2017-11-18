//
//  BackEnd.swift
//  Koloda_Example
//
//  Created by Beket on 11/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SQLite

class BackEnd: UIViewController {
    let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    
    let tasks = Table("tasks")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let min = Expression<Int64>("min")
    let max = Expression<Int64>("max")
    let info = Expression<String?>("info")
    let img = Expression<String?>("img")
    
    let results = Table("results")
    let result_id = Expression<Int64>("id")
    // let date = Expression<Date>("date")
    let amount = Expression<Int64>("amount")
    let task_id = Expression<Int64>("task_id")
    
    // Initial number of cards
    let numOfCards = 6
    
    func setupDB() {
        print("Hello1")
        let db = try! Connection("\(path)/db.sqlite3")
        print("Hello2")
        try! db.run( tasks.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(min)
            t.column(max)
            t.column(info)
            t.column(img)
        })
        
        try! db.run( results.create(ifNotExists: true) { t in
            t.column(result_id, primaryKey: true)
            // t.column(date)
            t.column(amount)
            t.column(task_id)
        })
        
        checkInitData()
        
    }
    
    func getDB() -> Connection {
        let db = try! Connection("\(path)/db.sqlite3")
        return db
    }
    
    // Now in real app, we would check if we already have the start data in our DB
    // We should check if the rows are in the DB
    func checkInitData() {
        let db = try! Connection("\(path)/db.sqlite3")
        let countTaskRows = try! db.scalar(tasks.count)
        let initName: [String] = ["Quran", "Say SubhanAllah", "Salah", "Say Alhamdulillah", "Say Allahu Akbaru", "Say Allah"]
        let initMin: [Int64] = [1, 1, 1, 1, 1, 1]
        let initMax: [Int64] = [20, 100, 5, 100, 100, 100]
        let initInfo: [String] = ["1", "2", "3", "4", "5", "6"]
        if countTaskRows < numOfCards {
            for index in 0..<numOfCards {
                do {
                    let rowid = try db.run(tasks.insert(name <- initName[index], min <- initMin[index], max <- initMax[index], info <- initInfo[index], img <- "Card_like_\(index + 1)")) //, date <- today))
                    print("inserted id: \(rowid)")
                } catch {
                    print("insertion failed: \(error)")
                }
            }
        }
    }
    
    struct TaskCard {
        let id: Int
        let name: String
        let min: Int
        let max: Int
        let info: String
        let img: String
    }
    
    // Method is called when we want to load a new card with given {@argument index}
    // Returns struct of TaskCard
    func loadData(_ index : Int) -> TaskCard {
            let db = try! Connection("\(path)/db.sqlite3")
            let query = tasks.filter(id == Int64(index))
            // let res = try! (db.prepare(query))
            var data : TaskCard?
            data = nil
            for res in try! db.prepare(query) {
            data = TaskCard(id: Int(res[id]), name: res[name], min: Int(res[min]), max: Int(res[max]), info: res[info]!, img: res[img]!)
            }
        return data!
    }
    
    func revertPrevData() {
        // TODO
    }
    
    // Method is called when we applied 'like' button for given {@argument index} (or index)
    // We save {@argument amount} as number of times we did implied action
  /*  func putData(_ index : Int, _ amt : Int) {
        let db = try! Connection("\(path)/db.sqlite3")
        // TODO: add date support
        // today =
        do {
            let rowid = try db.run(results.insert(task_id <- Int64(index), amount <- Int64(amt))) //, date <- today))
            print("inserted id: \(rowid)")
        } catch {
            print("insertion failed: \(error)")
        }
    }
    */


}
