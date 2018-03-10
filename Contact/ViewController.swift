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
    
    var showIndexPaths = false
    
    
    //tableview row 좌우로 보이게 하기
    @objc func handleShowIndexPath(){
        
        var indexPathToReload = [IndexPath]()
        
        //전체 색션과 행이 좌 우로 리로드
        for section in twoDimenstionArray.indices {
            for row in twoDimenstionArray[section].indices{
                let indexPath = IndexPath(row:row , section:section)
                indexPathToReload.append(indexPath)
            }
        }
        //토글 키 : 한번 눌렀을 때 오른쪽에서 나타나게, 두번 눌렀을 때 왼쪽에서
        showIndexPaths = !showIndexPaths
        let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
            tableView.reloadRows(at: indexPathToReload, with: animationStyle)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       //nav bar button 오른쪽에 생성
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "show indexPaht", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        //네비게이션 제목 등록
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
        if(showIndexPaths){
            
            cell.textLabel?.text = "\(name) Sectoin:\(indexPath.section) Row:\(indexPath.row)"
        }

        return cell
    }
}

