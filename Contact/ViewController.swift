//
//  ViewController.swift
//  Contact
//
//  Created by MacBookPro on 2018. 3. 10..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
let cellId = "cellId"
//let names = ["영균","은주","원일","태환","상찬","창민","대열","마더","파더","동생"]
//let anotherListOfNames = ["mike","nick","tom"]
//let chinaName = ["쨩거","리샤롱","쥬윤발"]
    
    
    let twoDimenstionArray = [
        ["영균","은주","원일","태환","상찬","창민","대열","마더","파더","태영"],
        ["mike","nick","tom"],
        ["쨩거","리샤롱","쥬윤발"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        //cell 등록
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    //섹션 제목 설정
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    //색션 수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimenstionArray.count
    }
    
    //섹션 별 행의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return twoDimenstionArray[section].count
       // if section == 0 {
        //    return names.count
       // }
        
    
    }

    //셀 구성 부분 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //deque 메서드는 register 메서드를 반드시 구현해야함!
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let name =  twoDimenstionArray[indexPath.section][indexPath.row]
        //let name = self.names[indexPath.row]
        cell.textLabel?.text = name
        cell.textLabel?.text = "\(name) Sectoin:\(indexPath.section) Row:\(indexPath.row)"
        return cell
    }
}


