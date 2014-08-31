//
//  ViewController.swift
//  junk201408-command
//
//  Created by grachro on 2014/08/31.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

typealias Command = (name:String, body:() -> Void)

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
                            
    @IBOutlet weak var tableView: UITableView!
    
     //UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self
        
        changeMainList()
    }

     //UIViewController
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    var commandlist:[Command] = []
    
    func addCommand(name:String, body:() -> Void = {}){
        commandlist.append(Command(name:name, body:body))
    }
    
    func changeMainList() {
        
        commandlist.removeAll(keepCapacity: false)
        
        addCommand("処理A（メッセージ表示）",body:{
            var alert = UIAlertView()
            alert.message = "ここに処理Aの実装"
            alert.addButtonWithTitle("OK")
            alert.show()
        })
        
        addCommand("処理B(サブリストBへ)",body:{
            self.changeSublistB()
        })
        
        addCommand("処理C(サブリストCへ)",body:{
            self.changeSublistC()
        })
        
        self.tableView.reloadData()
    }
    
    
    func changeSublistB() {
        commandlist.removeAll(keepCapacity: false)
        
        addCommand("サブリストB　[1項目]", body:{
            var alert = UIAlertView()
            alert.message = "ここサブリストB[1項目]の実装"
            alert.addButtonWithTitle("OK")
            alert.show()
        })
        
        addCommand("サブリストB　[2項目]", body:{
            var alert = UIAlertView()
            alert.message = "ここサブリストB[2項目]の実装"
            alert.addButtonWithTitle("OK")
            alert.show()
        })
        
        addCommand("サブリストCへ", body:{
            self.changeSublistC()
        })
        
        
        addCommand("戻る", body:{
            self.changeMainList()
        })
        
        self.tableView.reloadData()
    }
    
    func changeSublistC() {
        commandlist.removeAll(keepCapacity: false)
        
        addCommand("サブリストC　[1項目]", body:{
            self.changeSublistD()
        })
        
        addCommand("戻る", body:{
            self.changeMainList()
        })
        
        self.tableView.reloadData()
    }
 
    func changeSublistD() {
        commandlist.removeAll(keepCapacity: false)

        addCommand("データ1", body:{/*クリックしても特に何もしない*/})
        addCommand("データ2", body:{/*クリックしても特に何もしない*/})
        addCommand("データ3", body:{/*クリックしても特に何もしない*/})
        
        addCommand("メインリストへ戻る", body:{
            self.changeMainList()
        })
        
        self.tableView.reloadData()
    }
    
    
    //UITableViewDataSource
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return commandlist.count
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let command = commandlist[indexPath.row]
        
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel.text = "\(command.name)"
        
        return cell
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let command = commandlist[indexPath.row]
        command.body()
        
    }
}

