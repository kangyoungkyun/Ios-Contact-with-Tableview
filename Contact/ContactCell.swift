//
//  ContactCell.swift
//  Contact
//
//  Created by MacBookPro on 2018. 3. 11..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    // ViewController 전역 변수
    var link: ViewController?
    
    //필수
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //cell 에 버튼을 넣어주었다.
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "fav_star.png"), for: .normal)
        starButton.frame = CGRect(x:0,y:0,width:50,height:50)
        starButton.tintColor = .red
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = starButton
    }
    //별 눌렀을 때 -> ViewController 가서 해당 함수를 작동 시킨다.
    @objc func handleMarkAsFavorite(){
        link?.showMarkActoin(cell: self)
    }
    
    //필수
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
