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
    
    var twoDimenstionArray = [
        ExpandableNames(isExpanded: true, names:  ["영균","은주","원일","태환","상찬","창민","대열","마더","파더","태영"]),
        ExpandableNames(isExpanded: true, names:  ["mike","nick","tom"]),
        ExpandableNames(isExpanded: true, names:  ["쨩거","리샤롱","쥬윤발"])
        
    ]
    //좌우로 행 reload 체크
    var showIndexPaths = false
    
    
    //tableview row 좌우로 보이게 하기
    @objc func handleShowIndexPath(){
        
        var indexPathToReload = [IndexPath]()
        
        //전체 색션과 행이 좌 우로 리로드
        for section in twoDimenstionArray.indices {
            for row in twoDimenstionArray[section].names.indices{
                let indexPath = IndexPath(row:row , section:section)
                indexPathToReload.append(indexPath)
            }
        }
        //토글 키 : 한번 눌렀을 때 오른쪽에서 나타나게, 두번 눌렀을 때 왼쪽에서
        showIndexPaths = !showIndexPaths
        let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
        
    }
    //헤더 높이
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
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
    
    //닫기 클릭했을 때
    @ objc func handleExpandClose(button: UIButton){
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in twoDimenstionArray[section].names.indices{
            //print(0,row)
            let indexPath = IndexPath(row: row, section:section)
            indexPaths.append(indexPath)
        }
        
        //닫기 누르면 false
        let isExpanded = twoDimenstionArray[section].isExpanded
        twoDimenstionArray[section].isExpanded = !isExpanded
        //버튼 타이틀 바꿔주기
        button.setTitle(isExpanded ? "열기" : "닫기", for: .normal)
        
        if isExpanded {
            //삭제
            tableView.deleteRows(at: indexPaths, with: .fade)
            
        }else{
            //추가
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    //섹션 제목 설정
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.cyan
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    //색션 수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimenstionArray.count
    }
    
    //섹션 별 행의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //닫기 버튼 눌렸을 때
        if(!twoDimenstionArray[section].isExpanded){
            return 0
        }
        return twoDimenstionArray[section].names.count
        
    }
    
    //셀 구성 부분 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //deque 메서드는 register 메서드를 반드시 구현해야함!
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let name =  twoDimenstionArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = name
        if(showIndexPaths){
            cell.textLabel?.text = "\(name) Sectoin:\(indexPath.section) Row:\(indexPath.row)"
        }
        return cell
    }
}
