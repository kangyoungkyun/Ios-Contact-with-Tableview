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
        ExpandableNames(isExpanded: true, names:  ["영균","은주","원일","태환","상찬","창민","대열","마더","파더","태영"].map{  Contact(name: $0, hasFavorited: false)}),
        ExpandableNames(isExpanded: true, names:  ["mike","nick","tom"].map{  Contact(name: $0, hasFavorited: false)}),
        ExpandableNames(isExpanded: true, names:  ["쨩거","리샤롱","쥬윤발"].map{  Contact(name: $0, hasFavorited: false)})
        
    ]
    
    func showMarkActoin(cell: UITableViewCell){
      
        //눌린 cell의 위치가 나온다. section 0 : row 1
        guard let indexPathTapped = tableView.indexPath(for: cell) else {return}
        print(indexPathTapped)
        
        //선택된 이름 가져오기
        let contact = twoDimenstionArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited
        
        print("- showMarkActoin \(hasFavorited)") // 처음 값은 false - 회색
        //선택된 이름이 있는 배열에 contact 값에 hasFavorited 값을 변경해 준다.
        twoDimenstionArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
       
        //한번 눌렀을 때는 false 이기 때문에 빨간색
        cell.accessoryView?.tintColor = hasFavorited ? UIColor.lightGray : .red
        
        print(contact.name)
        print("- showMarkActoin-2 \(hasFavorited)")
    }
    
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
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ContactCell
        
        //cell에 있는 전역 변수 link는 ViewController다
        cell?.link = self
        
        let contact =  twoDimenstionArray[indexPath.section].names[indexPath.row]
        
        cell?.textLabel?.text = contact.name
        
        print("- cellForRowAt \(contact.hasFavorited)")
        
        //struct에 담긴 Bool 값으로 별 버튼 색깔 변경
        cell?.accessoryView?.tintColor = contact.hasFavorited ? UIColor.red : .lightGray
        if(showIndexPaths){
            cell?.textLabel?.text = "\(contact.name) Sectoin:\(indexPath.section) Row:\(indexPath.row)"
        }
        return cell!
    }
}
